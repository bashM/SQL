/**********************************************************************************************
*************** BasheeR. **********************
************** 565266905. ********************
************ CSCI370.***********************
********** Assingment 3. *****************
********* Mar 21, 2016. ****************
******* PLEASE READ THE READ ME FILE!**
**********************************************************************************************/
#include <iostream>
#include <occi.h>
#include <termios.h>
#include <unistd.h>
using namespace std;
using namespace oracle::occi;
// this where the coonection happen with the database and login!
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

// the applecation selctions
void show_help_menu()
{
	cout << "************************************* Help Menu **************************************" << endl << endl;
	cout << ">>>      D For Phone Records info:" << endl;
	cout << ">>>      N For Printing And Show Phone Line's Records:  " << endl;
	cout << ">>>      S For Monthly Reports:" << endl;
	cout << ">>>      Q For Terminating The Programme:" << endl << endl;
	cout << "***************************************************************************************"<< endl;
}

// the delete funcion in the D option!
void deleteRecord(Connection *conn, string rid){

    string queryStr = "delete from Call where rid = :1";
    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);

    stmt->setString(1, rid);
    cout << stmt->execute() << endl;
    cout<< " The ID has been deleted!" << endl;
    
    conn->terminateStatement(stmt);
    conn->commit();   
}

// option  d ( function )
void findcid(Connection *conn,string fromArea ,string fromNumber,string toArea,string toNumber){
   
    string queryStr = "select * from Call where fromArea=:1 AND  fromNumber =:2 AND toArea =:3 AND toNumber=:4 ";
    Statement *stmt = conn->createStatement();
    stmt->setSQL(queryStr);
    
    stmt->setString(1, fromArea );
    stmt->setString(2, fromNumber);
    stmt->setString(3, toArea);
    stmt->setString(4, toNumber);
    ResultSet *rs = stmt->executeQuery();
     
    cout << rs->getNumArrayRows() << endl << endl;
    
    char row=0;

    cout <<" rid  fromArea  fromNumber toArea  toNumber  startDate  startTime  duration" <<endl;
    while (rs->next()) {
        int rid = rs->getInt(1);
        string fromArea = rs->getString(2);
        string fromNumber = rs->getString(3);
        string toArea = rs->getString(4);
        string toNumber = rs->getString(5);
        string startDate = rs->getString(6);
        string startTime = rs->getString(7);
        string duration = rs->getString(8);

        cout << rid << " " << fromArea <<" "<< fromNumber <<" " << toArea <<" " << toNumber << " " << startDate;
        cout  << " " << startTime << " "<<  duration <<endl << endl;

        // I am using this to determine if user has some data ...
 	    row=1;
    }
    
    if ( row == 1 ) {
        cout << "Would you like to Delete some calls ? [Y/N]: " << endl;
        string answer;
        cin >> answer ;
        if (answer == "Y" || answer == "y" ) {
            cout << "Enter RID: " << endl ;
            string rid;
            cin >> rid;
            deleteRecord(conn, rid);
            findcid(conn,fromArea , fromNumber, toArea,toNumber);
        }

    } 
    else{
            cout << "Error: no entires for specificed inputs! " << endl;
            return ;
    }

    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);
}

// option N and its function: 
void phoneLines(Connection *conn, string areaCode,  string Pnumber){
    string queryStr = "select billingAddress, address, totalDuration from Customer Natural Join Phone, (select areaCode, Pnumber, sum(duration) as totalDuration from Phone natural join Call where (areaCode= fromArea and Pnumber=fromNumber) GROUP BY areaCode, Pnumber) where (Phone.Pnumber=:1 and Phone.areaCode=:2)";
    
    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);
    
    cout << areaCode << " " << Pnumber << endl;
	 stmt->setString(1, Pnumber);
	 stmt->setString(2, areaCode);
	
   ResultSet *rs = stmt->executeQuery();

	cout << "areaCode    Pnumber   billing Address  address  total Duration " << endl;
    
   while (rs->next()) {
        string areaCode = rs->getString(2);
        string Pnumber = rs->getString(1);
        string billingAddress = rs->getString(3); 

        cout << areaCode << " " << Pnumber << " "<< billingAddress << endl;
        } 

    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);	

}
// the monthly report
void monthly(Connection *conn, string StartDate){
    
    string queryStr = "select cid, name, billingAddress, count(rid)from customer Natural JOIN call Natural Join Phone where StartDate=:1 GROUP BY cid,name,billingAddress";

    Statement *stmt = conn->createStatement(); 
    stmt->setSQL(queryStr);
    
    stmt->setString(1, StartDate);
    ResultSet *rs = stmt->executeQuery();
	
    cout << "CID Name Billing-Address total-number-of-Calls"<<endl;
    
    while (rs->next()) {
	    string StartDate = rs->getString(1);
        string name = rs->getString(2);
        string billingAddress = rs->getString(3);
        string rid = rs->getString(4);
        cout << StartDate << " "<< name <<" "<< billingAddress<<" "<< rid << endl;  
    }


    stmt->closeResultSet(rs);
    conn->terminateStatement(stmt);

}
// the main function where users can selct options and get to the database info. 
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

			case 'd': {
                string fromArea; 
                string fromNumber;
                string toArea;
                string toNumber;
               
               cout << " please enter both phone numbers as [000 0000000 000 00000000]" << endl;
                    // user enters phone num 
				   cin >> fromArea >> fromNumber >> toArea >> toNumber;
                // test to make sure all enteries are valid  
				   findcid(conn,fromArea,fromNumber,toArea,toNumber);
				break;
	        }
            case 'q': {
                return 0;
     	    } 
            case 'n' :{
                string areaCode;
                string Pnumber;
                cout << " Please enter the phone number as [000 0000000]:" << endl;  
                cin >> areaCode >> Pnumber; 
                phoneLines(conn, areaCode, Pnumber);         
                break; 
            }
            case 's':{
                string StartDate;
                cout << "please enter the DATE to print a report YOU SHOULD USE [DD-MON-YY] eg; 07-MAR-15 :"<< endl;
                cin >> StartDate;
                monthly(conn,StartDate);
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
