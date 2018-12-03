#include <iostream>
#include <occi.h>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>
using namespace std;
using namespace oracle::occi;

string readPassword()
{
    struct termios settings;
    tcgetattr( STDIN_FILENO, &settings );
    settings.c_lflag =  (settings.c_lflag & ~(ECHO));
    tcsetattr( STDIN_FILENO, TCSANOW, &settings );

    string password = "";
    getline(cin, password);

    settings.c_lflag = (settings.c_lflag |   ECHO );
    tcsetattr( STDIN_FILENO, TCSANOW, &settings );
    return password;
}

struct STMT {
    string name;
    Statement *stmt;
};

int initStatements(Connection *conn, STMT * & statements)
{
    int size = 6;
    statements = new STMT[size];

    statements[0].name = "checkNumber";
    string queryStr = "select * from Phone where areaCode = :1 and pnumber = :2";
    statements[0].stmt = conn->createStatement(queryStr);

    statements[1].name = "displayRecords";
    queryStr = "select rid, startDate, startTime, duration\n \
                from Call\n \
                where fromArea = :1 and fromNumber = :2\n \
                      and toArea = :3 and toNumber = :4";
    statements[1].stmt = conn->createStatement(queryStr);

    statements[2].name = "removeCall";
    queryStr = "delete from call where rid = :1";
    statements[2].stmt = conn->createStatement(queryStr);

    statements[3].name = "summaryNumber";
    queryStr = "select billingAddress, address, sum(duration)\n \
                from Call C, Phone P, Customer M\n \
                where C.fromArea = P.areaCode\n \
                  and C.fromNumber = P.pnumber\n \
                  and M.cid = P.cid\n \
                  and P.areaCode = :1 and P.pnumber = :2\n \
                group by billingAddress, address";
    statements[3].stmt = conn->createStatement(queryStr);

    statements[4].name = "displayCalls";
    queryStr = "select rid, toArea, toNumber, startDate, startTime, duration\n \
                from Call\n \
                where fromArea = :1 and fromNumber = :2";
    statements[4].stmt = conn->createStatement(queryStr);

    statements[5].name = "summary";
    queryStr = "select cid, name, billingAddress, count(rid)\n \
                from Call C, Phone P, Customer M\n \
                where C.fromArea = P.areaCode\n \
                  and C.fromNumber = P.pnumber\n \
                  and M.cid = P.cid\n \
                  and to_char(C.startDate, 'yyyy') = :1\n \
                  and to_char(C.startDate, 'month') = :2\n \
                group by cid, name, billingAddress";
    statements[5].stmt = conn->createStatement(queryStr);
    
    return size;
}

Statement * findStatement(string name, STMT *statements, int size)
{
    for(int i = 0; i < size; i++) {
        if (statements[i].name == name)
            return statements[i].stmt;
    }
    return 0;
}

void terminateStatements(Connection *conn, STMT *statements, int size)
{
    for(int i = 0; i < size; i++)
        conn->terminateStatement(statements[i].stmt);
}


void menu()
{
    cout << "display menu\n";
}

string getCommand()
{
    string cmd;
    menu();
    cout << "Choose an option: ";
    cin >> cmd;
    for(int i = 0; i < cmd.length(); i++)
        cmd[i] = tolower(cmd[i]);

    return cmd;
}

bool checkNumber(Statement *stmt, string area, string number)
{
    stmt->setString(1, area);
    stmt->setString(2, number);

    ResultSet *rs = stmt->executeQuery();
    bool exists = rs->next();

    stmt->closeResultSet(rs);
    return exists;
}

void displayCallRecord(STMT *statements, int size)
{
    string fromArea, fromNumber, toArea, toNumber;
    cout << "Enter two phone numbers with area code: ";
    cin >> fromArea >> fromNumber >> toArea >> toNumber;

    Statement *stmt = findStatement("checkNumber", statements, size);
    if (!checkNumber(stmt, fromArea, fromNumber)) {
        cout << "Phone number (" << fromArea << ") " << fromNumber
             << " doesn't exist.\n";
        return;
    }

    if (!checkNumber(stmt, toArea, toNumber)) {
        cout << "Phone number (" << toArea << ") " << toNumber
             << " doesn't exist.\n";
        return;
    }

    stmt = findStatement("displayRecords", statements, size);
    stmt->setString(1, fromArea);
    stmt->setString(2, fromNumber);
    stmt->setString(3, toArea);
    stmt->setString(4, toNumber);

    ResultSet *rs = stmt->executeQuery();
    while (rs->next()) {
        cout << rs->getString(1) << ": "
             << "start at " << rs->getString(2) << " "
             << rs->getString(3) << " "
             << "for " << rs->getString(4) << "minutes" << endl; 
    }
    stmt->closeResultSet(rs);

    cout << "Do you want to remove a record? (y/n)";
    string answer;
    cin >> answer;
    if (tolower(answer[0]) == 'y') {
        string rid;
        cout << "Enter the rid of the call record you want to remove: ";
        cin >> rid;
        stmt = findStatement("removeCall", statements, size);
        stmt->setString(1, rid);
        int status = stmt->executeUpdate();
        if (status > 0) {
            cout << "Successfully removed record with rid = " << rid << endl;
        } else {
            cout << "Failed removing record with rid = " << rid << endl;
        }
    }
}

void displayRecords(STMT *statements, int size)
{
    string area, number;
    cout << "Enter one phone number with area code: ";
    cin >> area >> number;

    Statement *stmt = findStatement("checkNumber", statements, size);
    if (!checkNumber(stmt, area, number)) {
        cout << "Phone number (" << area << ") " << number
             << " doesn't exist.\n";
        return;
    }

    stmt = findStatement("summaryNumber", statements, size);
    stmt->setString(1, area);
    stmt->setString(2, number);
    ResultSet *rs = stmt->executeQuery();

    if (rs->next()) {
        cout << "Billing Address: " << rs->getString(1) << endl;
        cout << "Address: " << rs->getString(2) << endl;
        cout << "Total minutes: " << rs->getFloat(3) << endl;
    } else {
        cout << "No phone calls made by (" << area
             << ") " << number << endl;
    }

    stmt->closeResultSet(rs);

    stmt = findStatement("displayCalls", statements, size);
    stmt->setString(1, area);
    stmt->setString(2, number);
    rs = stmt->executeQuery();

    while (rs->next()) {
        cout << rs->getString(1) << ": "
             << "to (" << rs->getString(2)
             << ")" << rs->getString(3) << ", "
             << "start at " << rs->getString(4) << " "
             << rs->getString(5) << " "
             << "for " << rs->getString(6) << "minutes" << endl; 
    }
    stmt->closeResultSet(rs);
}

bool validYear(string year)
{
    if (year.length() != 4)
        return false;
    for(int i = 0; i < 4; i++) {
        if (!isdigit(year[i]))
            return false;
    }
    return true;
}

bool validMonth(string & month)
{
    string names[12] = {"january", "february", "march", "april",
                        "may", "june", "july", "august",
                        "september", "october", "november", "december"};
    int x = atoi(month.c_str());
    if (x >= 1 && x <= 12) {
        month = names[x-1];
        return true;
    }
    int len = month.length();
    bool match = false;
    for(int i = 0; i < 12; i++) {
        if (len <= names[i].length()) {
            match = true;
            for(int j = 0; j < len && match; j++) {
                if (tolower(month[j] != names[i][j]))
                    match = false;
            }
        }
        if (match) {
            month = names[i];
            return true;
        }
    }
    return false;
}

void showSummary(STMT *statements, int size)
{
    string year, month;
    cout << "Please enter year and then month: ";
    cin >> year >> month;

    if (!validYear(year) || !validMonth(month)) {
        cout << "Invalid year or month.\n";
        return;
    }

    Statement *stmt = findStatement("summary", statements, size);
    stmt->setString(1, year);
    stmt->setString(2, month);
    
    ResultSet *rs = stmt->executeQuery();
    while (rs->next()) {
        cout << "cid : " << rs->getString(1) << endl
             << "name : " << rs->getString(2) << endl
             << "billingaddress : " << rs->getString(3) << endl
             << "number of calls: " << rs->getInt(4) << endl
             << endl;
    }
    stmt->closeResultSet(rs);
}

int main()
{
    string userName;
    string password;
    const string connectString = "sunfire.csci.viu.ca";

    cout << "Your user name: ";
    getline(cin, userName);

    cout << "Your password: ";
    password = readPassword();
    cout << endl;

    Environment *env = Environment::createEnvironment();
    Connection *conn = env->createConnection
                          (userName, password, connectString);

    STMT *statements;
    int size = initStatements(conn, statements);

    Statement *stmt;

    string cmd = getCommand();

    while (cmd != "shutdown") {

        if (cmd == "d") {
            cout << "display and delete\n";
            displayCallRecord(statements, size);
        } else if (cmd == "n") {
            cout << "show records\n";
            displayRecords(statements, size);
        } else if (cmd == "s") {
            cout << "show summary\n";
            showSummary(statements, size);
        } else {
            cout << "Unknown command.\n";
        }

        cmd = getCommand();
    }


    terminateStatements(conn, statements, size);
    env->terminateConnection(conn);
    Environment::terminateEnvironment(env);

    return 0;
}

