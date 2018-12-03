#include <iostream>
#include <string>
#include <fstream>
#include <cstdio>

using namespace std;

void input();
void searchname();
void searchage();
void searchsalary();
void quit();
void displayall();
void search();
void deleteFile();
void editFile();

int main()
{   
       int choice;
       cout << "1.Input a new name" << endl;
       cout << "2.Search database for employee" << endl;
       cout << "3.Clear Log" << endl;
       cout << "4.Edit file" << endl;
       cout << "5.Exit Program" << endl;
       cin >> choice;

switch (choice){
       case 1:
            input();
            break;
       case 2:
            search();
            break;
       case 3:
            deleteFile();
            break;
       case 4:
            editFile();
            break;
       case 5:
            quit();
            break;
            
       cin.get();
            

       }
       }
void editFile()
{
 string name, input, newName,decision;
 int age;
 double salary;
 ifstream employee("newemployee.txt");
 if (!employee.eof()){
employee >> name >> age >> salary;
}
 
 cout << "Enter the name of the employee:";
 cin >> input;

 if (input == name)
 {
     
     cout << name << ' ' << age << ' ' << salary << endl;
     cout << "Is this the correct employee[y][n]:";
     cin >> decision;
     if (decision == "y"){
     cout << "Enter the new name:";
     cin >> newName;
     name = newName;      
           } 
            
     employee.close();
     }
    
     ofstream employee2("newemployee.txt", ios::app);
     employee2 << name << ' ' << age << ' ' << salary << endl;
     employee2.close();
 
 main();
     }
     
void input()
{       
 string name;
 int age; 
 long int salary;
 ofstream newemployee("newemployee.txt", ios::app);
 
 cout << "Enter the new employee's name" << endl;
 cin >> name;
 cin.sync();
 
 cout << "Enter the employee's age." << endl;
 cin >> age;
 
 
 cout << "Enter the employee's yearly salary" << endl;
 cin >> salary;

        
 newemployee << name << ' ' << age << ' ' << salary << endl;     
 newemployee.close(); 
 main();
     }
void searchname()
{
     ifstream employee("newemployee.txt");
     string name;
     string str, line;
     int age, offset;
     long int salary;
     
     cout << "Enter the emplyee's name:";
     cin >> str;
              
     while (employee >> name >> age >> salary){  
           if (str == name){
     
     cout << "Employee found" << endl;
     cout << "Name" << ' ' << "Age" << ' ' << "Salary" << endl;
     cout << "---------------" << endl;     
     cout << name << ' '<< age << ' ' << "$" <<  salary << endl;
     }
     }

            
     while (employee >> name ){
                 if (str != name){
       
                 cout << "Nobody under that name exists" << endl;     
                      
                      }
                      }
     
     main();
     
     
 }
void searchage()
 {
     ifstream employee("newemployee.txt");
     string name;
     int age ;
     int fage;
     long int salary;
     
     cout << "Enter the age of an employee:";
     cin >> fage;
     while (employee >> name >> age >> salary){
           if (fage == age){
     
                    cout << "Employee(s) found" << endl;
                    cout << "Name" << ' ' << "Age" << ' ' << "Salary" << endl;
                    cout << "---------------" << endl;
                    cout << name << ' ' << age << ' ' << "$" << salary << endl;
                    }
                    }
     while (employee >> age){      
           if (fage != age){
                    
                    cout << "No employee(s) found"<< endl;
                    
                    
                    }  
           }
           
           cin.get();
           main();
  }
void searchsalary()
{
     ifstream employee ("newemployee.txt");
     string name;
     int age ;
     long int salary;
     long int fsalary;
     
     cout << "Enter an employee's salary:";
     cin >> fsalary;
     while (employee >> name >> age >> salary){
           if (fsalary == salary ){
     
                       cout << "Employee found"<< endl;
                       cout << "Name" << ' ' << "Age" << ' ' << "Salary" << endl;
                       cout << "---------------" << endl;
                       cout << name << ' ' << age << ' ' << "$" << salary << endl;;
                       
                       }
                       }
     while (employee >> salary){
            if (fsalary != salary){
     
                cout << "No employee(s) found" << endl;
                }
           }
     
     cin.get();
     main();
 }
void quit()
{
 
 cout << "Thank you for using the ItalyHorse45 database program" << endl;

 cin.get();
     } 
void displayall()
{
     ifstream employee("newemployee.txt");
     int age;
     long int salary;
     string name;

     cout << "Entire employee database"<< endl;
     cout << "Name" << ' ' << "Age" << ' ' << "Salary" << endl;
     cout << "---------------" << endl;
     while (employee >> name >> age >> salary){
     cout << name << ' ' << age << ' ' << "$" << salary << endl ;
     }

     cin.get();
     main();
     
     }
void search()
{
     int age;
     string name;
     long double salary;
     int choice2;

     
     cout << "1.Search by name" << endl;
     cout << "2.Search by age" << endl;
     cout << "3.Search by salary" << endl;
     cout << "4.Display all employees" << endl;
     cout << "5.Back" << endl;
     cout << "6.Exit program" << endl;
     cin >> choice2;
     
     switch (choice2){
            case 1:
                 searchname();
                 break;
            case 2:
                 searchage();
                 break;
            case 3:
                 searchsalary();
                 break;
            case 4:
                 displayall();
                 break;
            case 5:
                 main();
                 break;
            case 6:
                 quit();
                 break;
                 }
                 
            
            
            
            }
void deleteFile()
{
     
     string decision;
     cout << "Are you sure?[Y]es[N]o" << endl;
     cin >> decision;
     if (decision == "y"){
     ofstream employee("newemployee.txt");

     cout << "Successfully Completed!" << endl;

     employee.close();
     main();
     }
     else{
          main();
          }
     }
