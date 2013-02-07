
new-project --named myfirstwebapp --topLevelPackage javamag.forge.myfirstproject;

persistence setup --provider HIBERNATE --container JBOSS_AS7 --database HSQLDB;

entity --named Person;

field string --named name;
field int --named age;

entity --named Adress;
field string --named street;
field string --named zip;
field string --named city;
cd ../Person.java;
field oneToMany --named adressen --fieldType javamag.forge.myfirstproject.model.Address;

scaffold setup;
scaffold from-entity javamag.forge.myfirstproject.model.*;

validation setup;
cd ~~;
cd src/main/java/javamag/forge/myfirstproject/model/Person.java;
constraint NotNull --onProperty name;
constraint Size --onProperty name --min 3 --max 25;

as7 setup
@/** /Users/sso/Documents/dev/adorsys/jboss-as-7.1.1.Final**/

