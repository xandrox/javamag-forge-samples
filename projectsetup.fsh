@/** Forge Script zum erstellen eines Multi-Module EAR Projektes mit EJB und WAR Teil*/;

echo  "Starting Script on OS" $System.getProperty("os.name");

def createComplexProject(projectName, package) {
  set ACCEPT_DEFAULTS true;
  
  new-project --named $projectName --topLevelPackage $package --type pom;
  
  new-project --named $projectName.concat(".service") --topLevelPackage $package.concat(".service") --type jar;
  maven set-groupid $package;maven set-artifactid $projectName.concat(".service");
  ejb setup;
  cd ..;
  
  new-project --named $projectName.concat(".gui") --topLevelPackage $package.concat(".gui") --type war;
  maven set-groupid $package; maven set-artifactid $projectName.concat(".gui");
  project add-dependency $package.concat(":").concat(projectName).concat(".service:1.0.0-SNAPSHOT");
  faces setup;
  cd ..;
  
  @/* leider kennt Forge aktuell keinen Typ ear, dies muss nachtraeglich im pom xml geaendert werden */;
  new-project --named $projectName.concat(".ear") --topLevelPackage $package.concat(".ear") --type pom;
  maven set-groupid $package;
  maven set-artifactid $projectName.concat(".ear");  
  project add-dependency $package.concat(":").concat(projectName).concat(".service:1.0.0-SNAPSHOT");
  project add-dependency $package.concat(":").concat(projectName).concat(".gui:1.0.0-SNAPSHOT");
  cd ..;
  
  build;
  
  set ACCEPT_DEFAULTS false;
};

if ( SHELL.promptBoolean("Create Project ?") ) {
  @projectName = SHELL.prompt("Project Name:");
  @packageName = SHELL.prompt("Package:");
  @createComplexProject(projectName, packageName);
};


