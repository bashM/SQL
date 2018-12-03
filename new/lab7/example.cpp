/**********************************************************************************************
*************** BasheeR. **********************
************** 565266905. ********************
************ CSCI370.***********************
********** Assingment 3. *****************
********* Mar 21, 2016. ****************
******  This applecation is designed to show the information of customers, and provide 
**** data about their phone calls and records.  there are 4 main functions that run
*** the database; the functions are using SQL to get data from tables that are given 
** in the databse sestem.  the main tables are Customer, device, phone, call, location,
* and service. I hope this program will meet up with all the requariment to get a good grades.
***********************************************************************************************/
#include <iostream>
#include <occi.h>
#include <termios.h>
#include <unistd.h>
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

void show_help_menu()
{
	cout << "**************************** HELP MENU **************************" << endl << endl;
	cout << ">>>  D For Phone Records info:" << endl;
   cout << ">>>  R To Delete A Phone Record:" << endl;
	cout << ">>>  N For Printing And Show Phone Line's Records:  " << endl;
	cout << ">>>  S For Monthly Reports:" << endl;
	cout << ">>>  Q For Terminating The Programme:" << endl << endl;
	cout << "*****************************************************************"<< endl;
}

void monthly(Connection *conn){
    
    string queryStr = "select cid, name, billingAddress, sum(rid) from customer Natural JOIN call where startDate =:1";
    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);
   
    string userinput;
    cout << "please enter date as (yyyy-mm-dd): ";
    cin >> userinput;

    userinput = userinput + "%";
    stmt->setString(1, userinput);

    ResultSet *rs = stmt->executeQuery();
    
    while (rs->next()) {
        int cid = rs->getInt(1);
        string name= rs->getString(1);
        string billingAddress = rs->getString(1);
        int phoneCalls = rs->getInt(1);
        cout << cid << " " << name << " " << billingAddress << "  " <<phoneCalls<< endl;
    }


    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);

}
void phoneLines(Connection *conn){
    string queryStr = "select billingAddress,address, total(Duration) from customer Natural JION phone Natural JION (select areaCode, pnumber, sum(duration) as total(Duration) from phone p JION call c on p.areaCode = c.fromNumber and p.pnumber = c.fromNumber) group by areaCode, pnumber";
    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);
   
    string userinput;
    cout << "Phone Line: ";
    cin >> userinput;

    userinput = userinput + "%";
    stmt->setString(1, userinput);

    ResultSet *rs = stmt->executeQuery();
    
    while (rs->next()) {
        int cid = rs->getInt(1);
        string name = rs->getString(2);
        string add = rs->getString(3); 
        cout << cid << " " << name << " " << add << endl;
    }


    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);	

}
void deleteRecord(Connection *conn){
//"select cid , name, billingaddress from customer  where name like :1";
    string queryStr = "delete from customer where cid like :1";
    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);
   
    string userinput;
    cout << "Phone call ID, you wish to be deleted: ";
    cin >> userinput;

    userinput = userinput + "%";
    stmt->setString(1, userinput);

    stmt->execute();

    cout<< " The ID has been deleted!" << endl;
    
   /* 
    		
    }*/
    
    conn->terminateStatement(stmt);
    conn->commit();   
}

void findcid(Connection *conn)
{
    //string queryStr = "select cid , name, billingaddress from customer  where name like :1";
    string queryStr = "select * from call where fromArea=:1 fromNumber =:2 toArea =:3 toNumber=:4 ";
    Statement *stmt = conn->createStatement();
    stmt->setSQL(queryStr);

    string userinput;
    cout << "Name: ";
    cin >> userinput;

    userinput = userinput + "%";
    stmt->setString(1, userinput);
    stmt->setString(2, userinput);
    stmt->setString(3, userinput);
    stmt->setString(4, userinput);
    ResultSet *rs = stmt->executeQuery();

    while (rs->next()) {
        int cid = rs->getInt(1);
        string name = rs->getString(2);
        string add = rs->getString(3); 
        cout << cid << " " << name << " " << add << endl;
    		
    }

    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);
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

    show_help_menu();
    	
    Environment *env = Environment::createEnvironment();
    Connection *conn = env->createConnection(userName, password, connectString);

    char option;
	int rfr_num=0;
	bool loop = true;
	int processed = 6;		//index of processed queue
	int index = -1;
	while(loop){
        //taking input of performing action
		string s;
		cout<<"Enter the action: ";
		cin>>option;
		getline(cin,s);

		switch(option){

			case 'D':{
  			    findcid(conn);
				break;
                case 'q': {
                    return 0;
                }
			}
            case 'R' :{
                deleteRecord(conn);
                break;
            }
         
            case 'N' :{
                phoneLines(conn);
                break; 
            }
         
            case 'S':{
                monthly(conn);
                break;
            }
            case 'Q' :{
                loop = false;
                break;
            }
    
    return 0;
    } 
  }
}
