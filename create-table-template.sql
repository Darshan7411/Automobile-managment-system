CREATE TABLE User (
    UID INT PRIMARY KEY AUTO_INCREMENT,
    uname VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(255),
    role ENUM('admin', 'customer', 'dealer','employee') NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active'
);

ALTER TABLE User 
MODIFY COLUMN role ENUM('admin', 'customer', 'dealer', 'employee') NOT NULL;


CREATE TABLE Customer (
    CID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    UID INT,  -- Foreign Key (Linking User)
    FOREIGN KEY (UID) REFERENCES User(UID) ON DELETE CASCADE
);

CREATE TABLE Vehicle (
    VID INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(100),
    model VARCHAR(100),
    year INT,
    type VARCHAR(50),
    mileage INT,
    price DECIMAL(10,2),
    color VARCHAR(50),
    status ENUM('available', 'sold', 'reserved') DEFAULT 'available'
);


CREATE TABLE TestDrive (
    TID INT PRIMARY KEY AUTO_INCREMENT,
    CID INT,
    VID INT,
    schedule DATETIME,
    status ENUM('pending', 'completed', 'canceled') DEFAULT 'pending',
    FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);


CREATE TABLE Service (
    SID INT PRIMARY KEY AUTO_INCREMENT,
    CID INT,
    VID INT,
    details TEXT,
    status ENUM('requested', 'in progress', 'completed', 'canceled') DEFAULT 'requested',
    FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);


CREATE TABLE Insurance (
    IID INT PRIMARY KEY AUTO_INCREMENT,
    VID INT,
    policy_number VARCHAR(50) UNIQUE,
    provider VARCHAR(100),
    start_date DATE,
    end_date DATE,
    coverage_details TEXT,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);

CREATE TABLE Orders (
    OID INT PRIMARY KEY AUTO_INCREMENT,
    CID INT,
    VID INT,
    order_date DATE,
    status ENUM('pending', 'confirmed', 'shipped', 'delivered') DEFAULT 'pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);
 

 CREATE TABLE Invoice (
    IID INT PRIMARY KEY AUTO_INCREMENT,
    OID INT,
    amount DECIMAL(10,2),
    payment_method ENUM('cash', 'credit card', 'online'),
    status ENUM('paid', 'unpaid', 'pending') DEFAULT 'pending',
    invoice_date DATE,
    FOREIGN KEY (OID) REFERENCES Orders(OID) ON DELETE CASCADE
);


CREATE TABLE Parts (
    PID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    supplier VARCHAR(100),
    stock INT,
    price DECIMAL(10,2)
);


CREATE TABLE Dealership (
    DID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100),
    opening_time TIME,
    closing_time TIME
);


CREATE TABLE PreOwned (
    POID INT PRIMARY KEY AUTO_INCREMENT,
    VID INT NOT NULL,
    previous_owner VARCHAR(100) NOT NULL,
    vehicle_condition ENUM('excellent', 'good', 'fair', 'poor') NOT NULL,
    resale_price DECIMAL(10,2) NOT NULL CHECK (resale_price > 0),
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);



CREATE TABLE VehicleFeatures (
    FID INT PRIMARY KEY AUTO_INCREMENT,
    VID INT NOT NULL,
    feature_name VARCHAR(255) NOT NULL,
    description TEXT,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);



CREATE TABLE Review (
    RID INT PRIMARY KEY AUTO_INCREMENT,
    CID INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE
);




CREATE TABLE Booking (
    BID INT PRIMARY KEY AUTO_INCREMENT,
    CID INT,
    VID INT,
    booking_date DATE,
    status ENUM('pending', 'confirmed', 'canceled') DEFAULT 'pending',
    FOREIGN KEY (CID) REFERENCES Customer(CID) ON DELETE CASCADE,
    FOREIGN KEY (VID) REFERENCES Vehicle(VID) ON DELETE CASCADE
);


CREATE TABLE Employee (
    EID INT PRIMARY KEY AUTO_INCREMENT,
    DID INT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (DID) REFERENCES Dealership(DID) ON DELETE CASCADE
);

SELECT * FROM User WHERE UID = (SELECT UID FROM Customer WHERE CID = 89);

SELECT * FROM Customer WHERE UID = 89;



INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Amit Sharma', 'amit.sharma01@gmail.com', '9876543210', 'password123', 'customer', 'active'),
('Priya Verma', 'priya.verma02@gmail.com', '8765432109', 'securePass456', 'customer', 'active'),
('Rajesh Kumar', 'rajesh.kumar03@gmail.com', '7654321098', 'strongPass789', 'admin', 'active'),
('Sneha Iyer', 'sneha.iyer04@gmail.com', '6543210987', 'hashedPass321', 'dealer', 'active'),
('Vikram Singh', 'vikram.singh05@gmail.com', '5432109876', 'vikramSecurePass', 'customer', 'inactive'),
('Suresh Reddy', 'suresh.reddy06@gmail.com', '4321098765', 'sureshPass99', 'employee', 'active'),
('Anjali Das', 'anjali.das07@gmail.com', '3210987654', 'anjaliDasPass', 'dealer', 'active'),
('Karan Mehta', 'karan.mehta08@gmail.com', '2109876543', 'karan@pass123', 'customer', 'inactive'),
('Meena Das', 'meena.das09@gmail.com', '9098765432', 'MeenaSecure99', 'customer', 'active'),
('Arun Nair', 'arun.nair10@gmail.com', '9987654321', 'NairPass987', 'employee', 'active'),
('Neha Patil', 'neha.patil11@gmail.com', '9871234560', 'NehaPass123', 'admin', 'active'),
('Ravi Chawla', 'ravi.chawla12@gmail.com', '9765432100', 'RaviChawla#99', 'customer', 'active'),
('Swati Singh', 'swati.singh13@gmail.com', '9654321090', 'SwatiSingh@pass', 'dealer', 'inactive'),
('Manoj Pandey', 'manoj.pandey14@gmail.com', '9543210980', 'ManojPandey999', 'customer', 'active'),
('Deepa Kaur', 'deepa.kaur15@gmail.com', '9432109870', 'DeepaSecure@77', 'employee', 'active'),
('Sandeep Yadav', 'sandeep.yadav16@gmail.com', '9321098760', 'SandeepYadav#pass', 'customer', 'inactive'),
('Ritu Chatterjee', 'ritu.chatterjee17@gmail.com', '9210987650', 'RituPass@123', 'dealer', 'active'),
('Rohit Khanna', 'rohit.khanna18@gmail.com', '9109876540', 'RohitKhannaPass', 'customer', 'active'),
('Ankita Sharma', 'ankita.sharma19@gmail.com', '9098765430', 'AnkitaSharma#99', 'employee', 'active'),
('Arvind Saxena', 'arvind.saxena20@gmail.com', '8987654329', 'ArvindSaxenaPass', 'admin', 'inactive'),
('Tina Reddy', 'tina.reddy21@gmail.com', '8876543219', 'TinaPass@111', 'customer', 'active'),
('Rakesh Sinha', 'rakesh.sinha22@gmail.com', '8765432198', 'RakeshPass123', 'employee', 'inactive'),
('Shruti Patel', 'shruti.patel23@gmail.com', '7654321987', 'ShrutiPass999', 'dealer', 'active'),
('Gautam Mishra', 'gautam.mishra24@gmail.com', '6543219876', 'GautamPass123', 'customer', 'inactive'),
('Megha Joshi', 'megha.joshi25@gmail.com', '5432198765', 'MeghaPass777', 'admin', 'active'),
('Vivek Das', 'vivek.das26@gmail.com', '4321987654', 'VivekDasPass', 'customer', 'inactive'),
('Kavita Bansal', 'kavita.bansal27@gmail.com', '3219876543', 'KavitaPass@pass', 'employee', 'active'),
('Akhil Nair', 'akhil.nair28@gmail.com', '2108765432', 'AkhilPass@123', 'dealer', 'active'),
('Suman Roy', 'suman.roy29@gmail.com', '1987654321', 'SumanRoyPass', 'customer', 'inactive'),
('Harsha Kapoor', 'harsha.kapoor30@gmail.com', '9876543211', 'HarshaKapoor99', 'admin', 'active'),
('Dev Singh', 'dev.singh31@gmail.com', '9765432101', 'DevPass777', 'customer', 'active'),
('Radhika Shetty', 'radhika.shetty32@gmail.com', '9654321091', 'RadhikaPass123', 'employee', 'inactive'),
('Satish Goel', 'satish.goel33@gmail.com', '9543210981', 'SatishGoelPass', 'dealer', 'active'),
('Nikhil Jha', 'nikhil.jha34@gmail.com', '9432109871', 'NikhilJha999', 'customer', 'active'),
('Pooja Pandit', 'pooja.pandit35@gmail.com', '9321098761', 'PoojaPandit@pass', 'employee', 'inactive'),
('Yashwant Reddy', 'yashwant.reddy36@gmail.com', '9210987651', 'YashwantPass@99', 'admin', 'active'),
('Pallavi Gupta', 'pallavi.gupta37@gmail.com', '9109876541', 'PallaviPass@111', 'customer', 'active'),
('Ramesh Sunder', 'ramesh.sunder38@gmail.com', '9098765431', 'RameshSunder999', 'dealer', 'inactive'),
('Vinod Bhatia', 'vinod.bhatia39@gmail.com', '8987654320', 'VinodBhatia@777', 'customer', 'active'),
('Gayatri Mohan', 'gayatri.mohan40@gmail.com', '8876543209', 'GayatriPass@111', 'employee', 'active');


INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Arjun Malhotra', 'arjun.malhotra41@gmail.com', '8765432197', 'ArjunPass@123', 'customer', 'active'),
('Divya Menon', 'divya.menon42@gmail.com', '7654321986', 'DivyaSecure@99', 'employee', 'inactive'),
('Sahil Kapoor', 'sahil.kapoor43@gmail.com', '6543219875', 'SahilKapoorPass', 'admin', 'active'),
('Tanvi Rathi', 'tanvi.rathi44@gmail.com', '5432198764', 'TanviRathi777', 'customer', 'active'),
('Harish Kumar', 'harish.kumar45@gmail.com', '4321987653', 'HarishKumarPass', 'dealer', 'inactive'),
('Preeti Chauhan', 'preeti.chauhan46@gmail.com', '3219876542', 'PreetiChauhan@123', 'employee', 'active'),
('Nitin Ghosh', 'nitin.ghosh47@gmail.com', '2108765431', 'NitinGhoshPass99', 'admin', 'inactive'),
('Sanjay Nair', 'sanjay.nair48@gmail.com', '1987654322', 'SanjayNairSecure', 'customer', 'active'),
('Kavya Saxena', 'kavya.saxena49@gmail.com', '9876543212', 'KavyaSaxenaPass', 'employee', 'active'),
('Mohit Verma', 'mohit.verma50@gmail.com', '9765432102', 'MohitVerma777', 'dealer', 'inactive'),
('Roshni Pillai', 'roshni.pillai51@gmail.com', '9654321092', 'RoshniPillaiPass', 'customer', 'active'),
('Rahul Yadav', 'rahul.yadav52@gmail.com', '9543210982', 'RahulYadavPass@99', 'admin', 'active'),
('Aarti Sinha', 'aarti.sinha53@gmail.com', '9432109872', 'AartiSinha777', 'customer', 'inactive'),
('Gagan Choudhary', 'gagan.choudhary54@gmail.com', '9321098762', 'GaganChoudharyPass', 'dealer', 'active'),
('Ananya Iyer', 'ananya.iyer55@gmail.com', '9210987652', 'AnanyaIyer@123', 'customer', 'active'),
('Rajiv Mehta', 'rajiv.mehta56@gmail.com', '9109876542', 'RajivMehtaSecure', 'employee', 'inactive'),
('Neelam Joshi', 'neelam.joshi57@gmail.com', '9098765432', 'NeelamJoshiPass', 'admin', 'active'),
('Abhinav Das', 'abhinav.das58@gmail.com', '8987654321', 'AbhinavDasPass99', 'customer', 'inactive'),
('Smita Reddy', 'smita.reddy59@gmail.com', '8876543208', 'SmitaReddy@pass', 'dealer', 'active'),
('Chetan Kumar', 'chetan.kumar60@gmail.com', '8765432196', 'ChetanKumar777', 'customer', 'active'),
('Ayesha Khan', 'ayesha.khan61@gmail.com', '7654321985', 'AyeshaKhanPass', 'employee', 'inactive'),
('Naveen Malhotra', 'naveen.malhotra62@gmail.com', '6543219874', 'NaveenPass123', 'admin', 'active'),
('Rina Das', 'rina.das63@gmail.com', '5432198763', 'RinaDasSecure', 'customer', 'active'),
('Alok Pandey', 'alok.pandey64@gmail.com', '4321987652', 'AlokPandeyPass99', 'dealer', 'inactive'),
('Tara Shetty', 'tara.shetty65@gmail.com', '3219876541', 'TaraShettyPass@pass', 'customer', 'active'),
('Ravindra Rao', 'ravindra.rao66@gmail.com', '2108765430', 'RavindraRao777', 'employee', 'active'),
('Meenal Saxena', 'meenal.saxena67@gmail.com', '1987654323', 'MeenalSaxenaPass', 'admin', 'inactive'),
('Dinesh Rathi', 'dinesh.rathi68@gmail.com', '9876543213', 'DineshRathiPass', 'customer', 'active'),
('Shweta Iyer', 'shweta.iyer69@gmail.com', '9765432103', 'ShwetaIyerSecure', 'dealer', 'active'),
('Kishore Yadav', 'kishore.yadav70@gmail.com', '9654321093', 'KishoreYadavPass99', 'customer', 'inactive'),
('Lata Kapoor', 'lata.kapoor71@gmail.com', '9543210983', 'LataKapoorPass@pass', 'employee', 'active'),
('Vijay Chatterjee', 'vijay.chatterjee72@gmail.com', '9432109873', 'VijayChatterjee777', 'admin', 'active'),
('Shalini Ghosh', 'shalini.ghosh73@gmail.com', '9321098763', 'ShaliniGhoshPass', 'customer', 'inactive'),
('Rajeev Nair', 'rajeev.nair74@gmail.com', '9210987653', 'RajeevNairSecure', 'dealer', 'active'),
('Neeraj Malhotra', 'neeraj.malhotra75@gmail.com', '9109876543', 'NeerajMalhotraPass99', 'customer', 'active'),
('Simran Kaur', 'simran.kaur76@gmail.com', '9098765433', 'SimranKaur@pass', 'employee', 'inactive'),
('Varun Joshi', 'varun.joshi77@gmail.com', '8987654322', 'VarunJoshi777', 'admin', 'active'),
('Jyoti Patel', 'jyoti.patel78@gmail.com', '8876543207', 'JyotiPatelPass', 'customer', 'active'),
('Mukesh Yadav', 'mukesh.yadav79@gmail.com', '8765432195', 'MukeshYadavSecure', 'dealer', 'inactive'),
('Anjali Choudhary', 'anjali.choudhary80@gmail.com', '7654321984', 'AnjaliChoudharyPass99', 'customer', 'active');

INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Amit Sharma', 'amit.sharma81@gmail.com', '7012345678', 'Amit@Pass123', 'customer', 'active'),
('Ritika Sinha', 'ritika.sinha82@gmail.com', '7023456789', 'Ritika@Secure99', 'employee', 'active'),
('Karan Verma', 'karan.verma83@gmail.com', '7034567890', 'KaranV@Pass', 'dealer', 'inactive'),
('Megha Nair', 'megha.nair84@gmail.com', '7045678901', 'MeghaNair777', 'customer', 'active'),
('Sumit Joshi', 'sumit.joshi85@gmail.com', '7056789012', 'Sumit@Secure99', 'admin', 'active'),
('Neha Kapoor', 'neha.kapoor86@gmail.com', '7067890123', 'NehaKPass@123', 'employee', 'inactive'),
('Pankaj Choudhary', 'pankaj.choudhary87@gmail.com', '7078901234', 'PankajC@Pass', 'dealer', 'active'),
('Swati Reddy', 'swati.reddy88@gmail.com', '7089012345', 'SwatiR@Secure', 'customer', 'active'),
('Ramesh Yadav', 'ramesh.yadav89@gmail.com', '7090123456', 'RameshY@99', 'admin', 'inactive'),
('Ankita Iyer', 'ankita.iyer90@gmail.com', '7101234567', 'AnkitaI@Pass', 'employee', 'active'),
('Praveen Nair', 'praveen.nair91@gmail.com', '7112345678', 'PraveenN@Secure', 'customer', 'active'),
('Geeta Malhotra', 'geeta.malhotra92@gmail.com', '7123456789', 'GeetaM@99', 'dealer', 'inactive'),
('Suresh Das', 'suresh.das93@gmail.com', '7134567890', 'SureshD@Pass', 'admin', 'active'),
('Shalini Mehta', 'shalini.mehta94@gmail.com', '7145678901', 'ShaliniM@Secure', 'employee', 'active'),
('Rajat Rathi', 'rajat.rathi95@gmail.com', '7156789012', 'RajatR@Pass99', 'customer', 'inactive'),
('Komal Saxena', 'komal.saxena96@gmail.com', '7167890123', 'KomalS@Secure', 'dealer', 'active'),
('Vikram Chatterjee', 'vikram.chatterjee97@gmail.com', '7178901234', 'VikramC@Pass', 'admin', 'inactive'),
('Pooja Singh', 'pooja.singh98@gmail.com', '7189012345', 'PoojaS@Secure', 'employee', 'active'),
('Harshit Patel', 'harshit.patel99@gmail.com', '7190123456', 'HarshitP@Pass', 'customer', 'active'),
('Ananya Kumar', 'ananya.kumar100@gmail.com', '7201234567', 'AnanyaK@Secure', 'dealer', 'inactive'),
('Jatin Joshi', 'jatin.joshi101@gmail.com', '7212345678', 'JatinJ@Pass', 'admin', 'active'),
('Deepika Sharma', 'deepika.sharma102@gmail.com', '7223456789', 'DeepikaS@Secure', 'employee', 'active'),
('Sagar Kapoor', 'sagar.kapoor103@gmail.com', '7234567890', 'SagarK@Pass99', 'customer', 'inactive'),
('Neetu Nair', 'neetu.nair104@gmail.com', '7245678901', 'NeetuN@Secure', 'dealer', 'active'),
('Mahesh Yadav', 'mahesh.yadav105@gmail.com', '7256789012', 'MaheshY@Pass', 'admin', 'inactive'),
('Vidya Iyer', 'vidya.iyer106@gmail.com', '7267890123', 'VidyaI@Secure', 'employee', 'active'),
('Ravi Malhotra', 'ravi.malhotra107@gmail.com', '7278901234', 'RaviM@Pass', 'customer', 'active'),
('Sonia Das', 'sonia.das108@gmail.com', '7289012345', 'SoniaD@Secure', 'dealer', 'inactive'),
('Yogesh Mehta', 'yogesh.mehta109@gmail.com', '7290123456', 'YogeshM@Pass', 'admin', 'active'),
('Tanisha Rathi', 'tanisha.rathi110@gmail.com', '7301234567', 'TanishaR@Secure', 'employee', 'active'),
('Nikhil Saxena', 'nikhil.saxena111@gmail.com', '7312345678', 'NikhilS@Pass99', 'customer', 'inactive'),
('Lavanya Chatterjee', 'lavanya.chatterjee112@gmail.com', '7323456789', 'LavanyaC@Secure', 'dealer', 'active'),
('Rohit Singh', 'rohit.singh113@gmail.com', '7334567890', 'RohitS@Pass', 'admin', 'inactive'),
('Monika Patel', 'monika.patel114@gmail.com', '7345678901', 'MonikaP@Secure', 'employee', 'active'),
('Ishaan Kumar', 'ishaan.kumar115@gmail.com', '7356789012', 'IshaanK@Pass', 'customer', 'active'),
('Vaishali Joshi', 'vaishali.joshi116@gmail.com', '7367890123', 'VaishaliJ@Secure', 'dealer', 'inactive'),
('Manoj Sharma', 'manoj.sharma117@gmail.com', '7378901234', 'ManojS@Pass99', 'admin', 'active'),
('Ritu Kapoor', 'ritu.kapoor118@gmail.com', '7389012345', 'RituK@Secure', 'employee', 'active'),
('Arvind Nair', 'arvind.nair119@gmail.com', '7390123456', 'ArvindN@Pass', 'customer', 'inactive'),
('Sangeeta Yadav', 'sangeeta.yadav120@gmail.com', '7401234567', 'SangeetaY@Secure', 'dealer', 'active'),
('Jagdish Iyer', 'jagdish.iyer121@gmail.com', '7412345678', 'JagdishI@Pass', 'admin', 'inactive'),
('Suhani Malhotra', 'suhani.malhotra122@gmail.com', '7423456789', 'SuhaniM@Secure', 'employee', 'active'),
('Harish Das', 'harish.das123@gmail.com', '7434567890', 'HarishD@Pass99', 'customer', 'active'),
('Priya Mehta', 'priya.mehta124@gmail.com', '7445678901', 'PriyaM@Secure', 'dealer', 'inactive'),
('Vikash Rathi', 'vikash.rathi125@gmail.com', '7456789012', 'VikashR@Pass', 'admin', 'active'),
('Sonia Saxena', 'sonia.saxena126@gmail.com', '7467890123', 'SoniaS@Secure', 'employee', 'active'),
('Rajeev Chatterjee', 'rajeev.chatterjee127@gmail.com', '7478901234', 'RajeevC@Pass99', 'customer', 'inactive');


INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Rahul Desai', 'rahul.desai128@gmail.com', '7489012345', 'RahulD@Pass123', 'customer', 'active'),
('Sneha Reddy', 'sneha.reddy129@gmail.com', '7490123456', 'SnehaR@Secure99', 'employee', 'active'),
('Vikram Sharma', 'vikram.sharma130@gmail.com', '7501234567', 'VikramS@Pass99', 'dealer', 'inactive'),
('Meenal Nair', 'meenal.nair131@gmail.com', '7512345678', 'MeenalN@SecurePass', 'customer', 'active'),
('Rohit Yadav', 'rohit.yadav132@gmail.com', '7523456789', 'RohitY@99Pass', 'admin', 'active'),
('Aditi Kapoor', 'aditi.kapoor133@gmail.com', '7534567890', 'AditiK@Pass123', 'employee', 'inactive'),
('Pranav Joshi', 'pranav.joshi134@gmail.com', '7545678901', 'PranavJ@Secure99', 'dealer', 'active'),
('Tanvi Mehta', 'tanvi.mehta135@gmail.com', '7556789012', 'TanviM@Pass', 'customer', 'active'),
('Varun Chatterjee', 'varun.chatterjee136@gmail.com', '7567890123', 'VarunC@Secure', 'admin', 'inactive'),
('Kavya Saxena', 'kavya.saxena137@gmail.com', '7578901234', 'KavyaS@Pass123', 'employee', 'active'),
('Arjun Iyer', 'arjun.iyer138@gmail.com', '7589012345', 'ArjunI@SecurePass', 'customer', 'active'),
('Simran Das', 'simran.das139@gmail.com', '7590123456', 'SimranD@99Pass', 'dealer', 'inactive'),
('Ramesh Rathi', 'ramesh.rathi140@gmail.com', '7601234567', 'RameshR@Pass123', 'admin', 'active'),
('Neelam Malhotra', 'neelam.malhotra141@gmail.com', '7612345678', 'NeelamM@Secure99', 'employee', 'active'),
('Karan Verma', 'karan.verma142@gmail.com', '7623456789', 'KaranV@Pass', 'customer', 'inactive'),
('Sanya Nair', 'sanya.nair143@gmail.com', '7634567890', 'SanyaN@Secure99', 'dealer', 'active'),
('Mahesh Yadav', 'mahesh.yadav144@gmail.com', '7645678901', 'MaheshY@Pass99', 'admin', 'inactive'),
('Ritika Kapoor', 'ritika.kapoor145@gmail.com', '7656789012', 'RitikaK@SecurePass', 'employee', 'active'),
('Pankaj Choudhary', 'pankaj.choudhary146@gmail.com', '7667890123', 'PankajC@99Pass', 'customer', 'active'),
('Swati Reddy', 'swati.reddy147@gmail.com', '7678901234', 'SwatiR@Pass123', 'dealer', 'inactive'),
('Ankita Iyer', 'ankita.iyer148@gmail.com', '7689012345', 'AnkitaI@Secure99', 'admin', 'active'),
('Suresh Joshi', 'suresh.joshi149@gmail.com', '7690123456', 'SureshJ@Pass', 'employee', 'active'),
('Geeta Mehta', 'geeta.mehta150@gmail.com', '7701234567', 'GeetaM@SecurePass', 'customer', 'inactive'),
('Deepak Saxena', 'deepak.saxena151@gmail.com', '7712345678', 'DeepakS@99Pass', 'dealer', 'active'),
('Lavanya Chatterjee', 'lavanya.chatterjee152@gmail.com', '7723456789', 'LavanyaC@Pass123', 'admin', 'inactive'),
('Rajat Malhotra', 'rajat.malhotra153@gmail.com', '7734567890', 'RajatM@Secure99', 'employee', 'active'),
('Ananya Patel', 'ananya.patel154@gmail.com', '7745678901', 'AnanyaP@Pass', 'customer', 'active'),
('Jatin Rathi', 'jatin.rathi155@gmail.com', '7756789012', 'JatinR@SecurePass', 'dealer', 'inactive'),
('Vidya Sharma', 'vidya.sharma156@gmail.com', '7767890123', 'VidyaS@99Pass', 'admin', 'active'),
('Neha Kumar', 'neha.kumar157@gmail.com', '7778901234', 'NehaK@Pass123', 'employee', 'active'),
('Harish Das', 'harish.das158@gmail.com', '7789012345', 'HarishD@Secure99', 'customer', 'inactive'),
('Priya Kapoor', 'priya.kapoor159@gmail.com', '7790123456', 'PriyaK@Pass99', 'dealer', 'active'),
('Rajeev Verma', 'rajeev.verma160@gmail.com', '7801234567', 'RajeevV@SecurePass', 'admin', 'inactive'),
('Ritu Yadav', 'ritu.yadav161@gmail.com', '7812345678', 'RituY@99Pass', 'employee', 'active'),
('Nikhil Choudhary', 'nikhil.choudhary162@gmail.com', '7823456789', 'NikhilC@Pass123', 'customer', 'active'),
('Sonia Joshi', 'sonia.joshi163@gmail.com', '7834567890', 'SoniaJ@Secure99', 'dealer', 'inactive'),
('Ravi Mehta', 'ravi.mehta164@gmail.com', '7845678901', 'RaviM@Pass99', 'admin', 'active'),
('Tanisha Saxena', 'tanisha.saxena165@gmail.com', '7856789012', 'TanishaS@SecurePass', 'employee', 'active'),
('Kavita Iyer', 'kavita.iyer166@gmail.com', '7867890123', 'KavitaI@99Pass', 'customer', 'inactive'),
('Pawan Rathi', 'pawan.rathi167@gmail.com', '7878901234', 'PawanR@Pass123', 'dealer', 'active'),
('Simran Chatterjee', 'simran.chatterjee168@gmail.com', '7889012345', 'SimranC@Secure99', 'admin', 'inactive'),
('Ajay Malhotra', 'ajay.malhotra169@gmail.com', '7890123456', 'AjayM@Pass99', 'employee', 'active');


INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Akhil Sharma', 'akhil.sharma170@gmail.com', '7901234567', 'AkhilS@Pass123', 'customer', 'active'),
('Bhavna Reddy', 'bhavna.reddy171@gmail.com', '7912345678', 'BhavnaR@Secure99', 'employee', 'active'),
('Chirag Yadav', 'chirag.yadav172@gmail.com', '7923456789', 'ChiragY@Pass99', 'dealer', 'inactive'),
('Divya Mehta', 'divya.mehta173@gmail.com', '7934567890', 'DivyaM@SecurePass', 'customer', 'active'),
('Eshwar Malhotra', 'eshwar.malhotra174@gmail.com', '7945678901', 'EshwarM@99Pass', 'admin', 'active'),
('Farhan Saxena', 'farhan.saxena175@gmail.com', '7956789012', 'FarhanS@Pass123', 'employee', 'inactive'),
('Gitanjali Choudhary', 'gitanjali.choudhary176@gmail.com', '7967890123', 'GitanjaliC@Secure99', 'dealer', 'active'),
('Harshit Joshi', 'harshit.joshi177@gmail.com', '7978901234', 'HarshitJ@Pass', 'customer', 'inactive'),
('Ishita Kapoor', 'ishita.kapoor178@gmail.com', '7989012345', 'IshitaK@SecurePass', 'admin', 'active'),
('Jatin Verma', 'jatin.verma179@gmail.com', '7990123456', 'JatinV@99Pass', 'employee', 'active'),
('Kiran Patel', 'kiran.patel180@gmail.com', '8001234567', 'KiranP@Pass123', 'customer', 'inactive'),
('Lavanya Iyer', 'lavanya.iyer181@gmail.com', '8012345678', 'LavanyaI@Secure99', 'dealer', 'active'),
('Manish Das', 'manish.das182@gmail.com', '8023456789', 'ManishD@Pass99', 'admin', 'inactive'),
('Neha Rathi', 'neha.rathi183@gmail.com', '8034567890', 'NehaR@SecurePass', 'employee', 'active'),
('Omkar Chatterjee', 'omkar.chatterjee184@gmail.com', '8045678901', 'OmkarC@99Pass', 'customer', 'active'),
('Pooja Yadav', 'pooja.yadav185@gmail.com', '8056789012', 'PoojaY@Pass123', 'dealer', 'inactive'),
('Qasim Malhotra', 'qasim.malhotra186@gmail.com', '8067890123', 'QasimM@Secure99', 'admin', 'active'),
('Ravi Mehta', 'ravi.mehta187@gmail.com', '8078901234', 'RaviM@Pass99', 'employee', 'inactive'),
('Shalini Sharma', 'shalini.sharma188@gmail.com', '8089012345', 'ShaliniS@SecurePass', 'customer', 'active'),
('Tanmay Kapoor', 'tanmay.kapoor189@gmail.com', '8090123456', 'TanmayK@99Pass', 'dealer', 'inactive'),
('Ujjwal Joshi', 'ujjwal.joshi190@gmail.com', '8101234567', 'UjjwalJ@Pass123', 'admin', 'active'),
('Vasundhara Saxena', 'vasundhara.saxena191@gmail.com', '8112345678', 'VasundharaS@Secure99', 'employee', 'active');


UPDATE User 
SET role = 'employee' 
WHERE role = 'admin';

SELECT count(DISTINCT(uname))
from user;


INSERT INTO User (uname, email, phone, password, role, status) VALUES
('Aarav Sharma', 'aarav.sharma01@gmail.com', '9001234567', 'Aarav@Pass123', 'customer', 'active'),
('Bhavya Patel', 'bhavya.patel02@gmail.com', '9012345678', 'Bhavya@Secure99', 'customer', 'active'),
('Chirag Reddy', 'chirag.reddy03@gmail.com', '9023456789', 'Chirag@Pass99', 'customer', 'inactive'),
('Divya Iyer', 'divya.iyer04@gmail.com', '9034567890', 'Divya@SecurePass', 'customer', 'active'),
('Eshan Kapoor', 'eshan.kapoor05@gmail.com', '9045678901', 'Eshan@99Pass', 'customer', 'active'),
('Farhan Mehta', 'farhan.mehta06@gmail.com', '9056789012', 'Farhan@Pass123', 'customer', 'inactive'),
('Gitanjali Yadav', 'gitanjali.yadav07@gmail.com', '9067890123', 'Gitanjali@Secure99', 'customer', 'active'),
('Harshit Choudhary', 'harshit.choudhary08@gmail.com', '9078901234', 'Harshit@Pass', 'customer', 'inactive'),
('Ishita Joshi', 'ishita.joshi09@gmail.com', '9089012345', 'Ishita@SecurePass', 'customer', 'active'),
('Jatin Verma', 'jatin.verma10@gmail.com', '9090123456', 'Jatin@99Pass', 'customer', 'inactive'),
('Kiran Das', 'kiran.das11@gmail.com', '9101234567', 'Kiran@Pass123', 'customer', 'active'),
('Lavanya Malhotra', 'lavanya.malhotra12@gmail.com', '9112345678', 'Lavanya@Secure99', 'customer', 'inactive'),
('Manish Saxena', 'manish.saxena13@gmail.com', '9123456789', 'Manish@Pass99', 'customer', 'active'),
('Neha Rathi', 'neha.rathi14@gmail.com', '9134567890', 'Neha@SecurePass', 'customer', 'active'),
('Omkar Chatterjee', 'omkar.chatterjee15@gmail.com', '9145678901', 'Omkar@99Pass', 'customer', 'inactive'),
('Pooja Yadav', 'pooja.yadav16@gmail.com', '9156789012', 'Pooja@Pass123', 'customer', 'active'),
('Qasim Mehta', 'qasim.mehta17@gmail.com', '9167890123', 'Qasim@Secure99', 'customer', 'inactive'),
('Ravi Sharma', 'ravi.sharma18@gmail.com', '9178901234', 'Ravi@Pass99', 'customer', 'active'),
('Shalini Kapoor', 'shalini.kapoor19@gmail.com', '9189012345', 'Shalini@SecurePass', 'customer', 'active'),
('Tanmay Joshi', 'tanmay.joshi20@gmail.com', '9190123456', 'Tanmay@99Pass', 'customer', 'inactive');


select * from customer;


INSERT INTO Customer (name, email, phone, UID)
SELECT uname, email, phone, UID 
FROM User 
WHERE role = 'customer';

INSERT INTO Dealership (name, location, phone, email, opening_time, closing_time) VALUES
('Maruti Suzuki Arena', 'Mumbai, Maharashtra', '9123456789', 'contact@marutisuzuki.com', '09:00:00', '18:00:00'),
('Hyundai Showroom', 'Delhi, Delhi', '9123456790', 'info@hyundai.com', '09:00:00', '18:00:00'),
('Tata Motors', 'Bangalore, Karnataka', '9123456791', 'support@tatamotors.com', '09:00:00', '18:00:00'),
('Mahindra & Mahindra', 'Chennai, Tamil Nadu', '9123456792', 'sales@mahindra.com', '09:00:00', '18:00:00'),
('Honda Cars', 'Kolkata, West Bengal', '9123456793', 'service@hondacars.com', '09:00:00', '18:00:00'),
('Toyota Showroom', 'Pune, Maharashtra', '9123456794', 'contact@toyota.com', '09:00:00', '18:00:00'),
('Ford Dealership', 'Ahmedabad, Gujarat', '9123456795', 'info@ford.com', '09:00:00', '18:00:00'),
('Renault Showroom', 'Hyderabad, Telangana', '9123456796', 'support@renault.com', '09:00:00', '18:00:00'),
('Nissan Dealership', 'Chandigarh, Punjab', '9123456797', 'sales@nissan.com', '09:00:00', '18:00:00'),
('Volkswagen Showroom', 'Jaipur, Rajasthan', '9123456798', 'service@volkswagen.com', '09:00:00', '18:00:00'),
('Skoda Dealership', 'Lucknow, Uttar Pradesh', '9123456799', 'contact@skoda.com', '09:00:00', '18:00:00'),
('Kia Motors', 'Bhopal, Madhya Pradesh', '9123456700', 'info@kia.com', '09:00:00', '18:00:00'),
('MG Motors', 'Patna, Bihar', '9123456701', 'support@mgmotors.com', '09:00:00', '18:00:00'),
('Jeep Showroom', 'Thiruvananthapuram, Kerala', '9123456702', 'sales@jeep.com', '09:00:00', '18:00:00'),
('Fiat Dealership', 'Guwahati, Assam', '9123456703', 'service@fiat.com', '09:00:00', '18:00:00'),
('Mitsubishi Showroom', 'Ranchi, Jharkhand', '9123456704', 'contact@mitsubishi.com', '09:00:00', '18:00:00'),
('Isuzu Motors', 'Raipur, Chhattisgarh', '9123456705', 'info@isuzu.com', '09:00:00', '18:00:00'),
('Datsun Dealership', 'Panaji, Goa', '9123456706', 'support@datsun.com', '09:00:00', '18:00:00'),
('Lexus Showroom', 'Shimla, Himachal Pradesh', '9123456707', 'sales@lexus.com', '09:00:00', '18:00:00'),
('Jaguar Dealership', 'Dehradun, Uttarakhand', '9123456708', 'service@jaguar.com', '09:00:00', '18:00:00'),
('Land Rover Showroom', 'Imphal, Manipur', '9123456709', 'contact@landrover.com', '09:00:00', '18:00:00'),
('Volvo Dealership', 'Shillong, Meghalaya', '9123456710', 'info@volvo.com', '09:00:00', '18:00:00'),
('Porsche Showroom', 'Aizawl, Mizoram', '9123456711', 'support@porsche.com', '09:00:00', '18:00:00'),
('Ferrari Dealership', 'Kohima, Nagaland', '9123456712', 'sales@ferrari.com', '09:00:00', '18:00:00'),
('Lamborghini Showroom', 'Agartala, Tripura', '9123456713', 'service@lamborghini.com', '09:00:00', '18:00:00'),
('Bentley Dealership', 'Itanagar, Arunachal Pradesh', '9123456714', 'contact@bentley.com', '09:00:00', '18:00:00'),
('Rolls Royce Showroom', 'Gangtok, Sikkim', '9123456715', 'info@rollsroyce.com', '09:00:00', '18:00:00'),
('Aston Martin Dealership', 'Silvassa, Dadra and Nagar Haveli', '9123456716', 'support@astonmartin.com', '09:00:00', '18:00:00'),
('Maserati Showroom', 'Daman, Daman and Diu', '9123456717', 'sales@maserati.com', '09:00:00', '18:00:00'),
('Bugatti Dealership', 'Kavaratti, Lakshadweep', '9123456718', 'service@bugatti.com', '09:00:00', '18:00:00'),
('Pagani Showroom', 'Port Blair, Andaman and Nicobar Islands', '9123456719', 'contact@pagani.com', '09:00:00', '18:00:00'),
('Tesla Dealership', 'Leh, Ladakh', '9123456720', 'info@tesla.com', '09:00:00', '18:00:00'),
('Rivian Showroom', 'Srinagar, Jammu and Kashmir', '9123456721', 'support@rivian.com', '09:00:00', '18:00:00'),
('Lucid Motors', 'Amritsar, Punjab', '9123456722', 'sales@lucidmotors.com', '09:00:00', '18:00:00'),
('Polestar Dealership', 'Kanpur, Uttar Pradesh', '9123456723', 'service@polestar.com', '09:00:00', '18:00:00'),
('Genesis Showroom', 'Indore, Madhya Pradesh', '9123456724', 'contact@genesis.com', '09:00:00', '18:00:00'),
('Infiniti Dealership', 'Vadodara, Gujarat', '9123456725', 'info@infiniti.com', '09:00:00', '18:00:00'),
('Acura Showroom', 'Nagpur, Maharashtra', '9123456726', 'support@acura.com', '09:00:00', '18:00:00'),
('Alfa Romeo Dealership', 'Coimbatore, Tamil Nadu', '9123456727', 'sales@alfaromeo.com', '09:00:00', '18:00:00'),
('Cadillac Showroom', 'Vijayawada, Andhra Pradesh', '9123456728', 'service@cadillac.com', '09:00:00', '18:00:00'),
('Chevrolet Dealership', 'Mysore, Karnataka', '9123456729', 'contact@chevrolet.com', '09:00:00', '18:00:00'),
('Chrysler Showroom', 'Surat, Gujarat', '9123456730', 'info@chrysler.com', '09:00:00', '18:00:00'),
('Dodge Dealership', 'Nashik, Maharashtra', '9123456731', 'support@dodge.com', '09:00:00', '18:00:00'),
('GMC Showroom', 'Aurangabad, Maharashtra', '9123456732', 'sales@gmc.com', '09:00:00', '18:00:00'),
('Hummer Dealership', 'Jabalpur, Madhya Pradesh', '9123456733', 'service@hummer.com', '09:00:00', '18:00:00'),
('Lincoln Showroom', 'Gwalior, Madhya Pradesh', '9123456734', 'contact@lincoln.com', '09:00:00', '18:00:00'),
('Ram Dealership', 'Jodhpur, Rajasthan', '9123456735', 'info@ram.com', '09:00:00', '18:00:00'),
('Saab Showroom', 'Madurai, Tamil Nadu', '9123456736', 'support@saab.com', '09:00:00', '18:00:00'),
('Saturn Dealership', 'Varanasi, Uttar Pradesh', '9123456737', 'sales@saturn.com', '09:00:00', '18:00:00'),
('Scion Showroom', 'Meerut, Uttar Pradesh', '9123456738', 'service@scion.com', '09:00:00', '18:00:00');


select count(role)
from user 
where role="employee";


INSERT INTO Employee (DID, name, email, phone, position, salary)
SELECT 
    (SELECT DID FROM Dealership ORDER BY RAND() LIMIT 1) AS DID,
    u.uname, 
    u.email, 
    u.phone, 
    CASE 
        WHEN RAND() < 0.17 THEN 'Manager'
        WHEN RAND() < 0.34 THEN 'Sales Executive'
        WHEN RAND() < 0.51 THEN 'Technician'
        WHEN RAND() < 0.68 THEN 'Accountant'
        WHEN RAND() < 0.85 THEN 'Customer Service'
        ELSE 'Support Staff'
    END AS position,
    ROUND(30000 + (RAND() * 20000), 2) AS salary  -- Random salary between 30000 and 50000
FROM 
    User u
WHERE 
    u.role = 'employee';


select * from employee;

INSERT INTO Vehicle (make, model, year, type, mileage, price, color, status) VALUES
('Maruti Suzuki', 'Swift', 2022, 'Hatchback', 20, 500000.00, 'Red', 'available'),
('Hyundai', 'i20', 2021, 'Hatchback', 18, 600000.00, 'Blue', 'available'),
('Tata', 'Nexon', 2023, 'SUV', 17, 800000.00, 'White', 'available'),
('Mahindra', 'XUV500', 2020, 'SUV', 15, 1200000.00, 'Black', 'available'),
('Honda', 'City', 2022, 'Sedan', 16, 900000.00, 'Silver', 'available'),
('Toyota', 'Innova', 2021, 'MPV', 12, 1500000.00, 'Grey', 'available'),
('Ford', 'EcoSport', 2020, 'SUV', 14, 1000000.00, 'Orange', 'available'),
('Renault', 'Kwid', 2023, 'Hatchback', 22, 400000.00, 'Yellow', 'available'),
('Nissan', 'Magnite', 2022, 'SUV', 18, 700000.00, 'Green', 'available'),
('Volkswagen', 'Polo', 2021, 'Hatchback', 19, 650000.00, 'Red', 'available'),
('Skoda', 'Rapid', 2020, 'Sedan', 16, 850000.00, 'Blue', 'available'),
('Kia', 'Seltos', 2023, 'SUV', 17, 1100000.00, 'White', 'available'),
('MG', 'Hector', 2022, 'SUV', 14, 1300000.00, 'Black', 'available'),
('Jeep', 'Compass', 2021, 'SUV', 15, 1600000.00, 'Silver', 'available'),
('Fiat', 'Punto', 2020, 'Hatchback', 20, 500000.00, 'Grey', 'available'),
('Mitsubishi', 'Pajero', 2023, 'SUV', 10, 2000000.00, 'Orange', 'available'),
('Isuzu', 'D-Max', 2022, 'Pickup', 13, 1800000.00, 'Green', 'available'),
('Datsun', 'Go', 2021, 'Hatchback', 19, 400000.00, 'Red', 'available'),
('Lexus', 'ES', 2020, 'Sedan', 12, 5000000.00, 'Blue', 'available'),
('Jaguar', 'XF', 2023, 'Sedan', 11, 6000000.00, 'White', 'available'),
('Land Rover', 'Discovery', 2022, 'SUV', 9, 7000000.00, 'Black', 'available'),
('Volvo', 'XC90', 2021, 'SUV', 10, 8000000.00, 'Silver', 'available'),
('Porsche', 'Cayenne', 2020, 'SUV', 8, 9000000.00, 'Grey', 'available'),
('Ferrari', '488', 2023, 'Coupe', 7, 30000000.00, 'Red', 'available'),
('Lamborghini', 'Huracan', 2022, 'Coupe', 6, 35000000.00, 'Yellow', 'available'),
('Bentley', 'Bentayga', 2021, 'SUV', 8, 40000000.00, 'Blue', 'available'),
('Rolls Royce', 'Ghost', 2020, 'Sedan', 7, 50000000.00, 'White', 'available'),
('Aston Martin', 'DB11', 2023, 'Coupe', 9, 25000000.00, 'Black', 'available'),
('Maserati', 'Ghibli', 2022, 'Sedan', 10, 20000000.00, 'Silver', 'available'),
('Bugatti', 'Chiron', 2021, 'Coupe', 5, 70000000.00, 'Blue', 'available'),
('Pagani', 'Huayra', 2020, 'Coupe', 4, 80000000.00, 'Red', 'available'),
('Tesla', 'Model S', 2023, 'Sedan', 0, 10000000.00, 'White', 'available'),  -- Electric car
('Rivian', 'R1T', 2022, 'Pickup', 0, 9000000.00, 'Black', 'available'),  -- Electric car
('Lucid', 'Air', 2021, 'Sedan', 0, 11000000.00, 'Silver', 'available'),  -- Electric car
('Polestar', '2', 2020, 'Sedan', 0, 12000000.00, 'Grey', 'available'),  -- Electric car
('Genesis', 'G80', 2023, 'Sedan', 12, 13000000.00, 'Blue', 'available'),
('Infiniti', 'QX80', 2022, 'SUV', 10, 14000000.00, 'White', 'available'),
('Acura', 'MDX', 2021, 'SUV', 11, 15000000.00, 'Black', 'available'),
('Alfa Romeo', 'Giulia', 2020, 'Sedan', 13, 16000000.00, 'Red', 'available'),
('Cadillac', 'Escalade', 2023, 'SUV', 9, 17000000.00, 'Blue', 'available'),
('Chevrolet', 'Tahoe', 2022, 'SUV', 10, 18000000.00, 'White', 'available'),
('Chrysler', '300', 2021, 'Sedan', 12, 19000000.00, 'Black', 'available'),
('Dodge', 'Charger', 2020, 'Sedan', 11, 20000000.00, 'Silver', 'available'),
('GMC', 'Yukon', 2023, 'SUV', 9, 21000000.00, 'Grey', 'available'),
('Hummer', 'H2', 2022, 'SUV', 8, 22000000.00, 'Red', 'available'),
('Lincoln', 'Navigator', 2021, 'SUV', 10, 23000000.00, 'Blue', 'available'),
('Ram', '1500', 2020, 'Pickup', 12, 24000000.00, 'White', 'available'),
('Saab', '9-3', 2023, 'Sedan', 14, 25000000.00, 'Black', 'available'),
('Saturn', 'Aura', 2022, 'Sedan', 13, 26000000.00, 'Silver', 'available'),
('Scion', 'tC', 2021, 'Coupe', 15, 27000000.00, 'Grey', 'available'),
('Suzuki', 'Baleno', 2020, 'Hatchback', 21, 600000.00, 'Red', 'available'),
('Hyundai', 'Creta', 2023, 'SUV', 17, 1000000.00, 'Blue', 'available'),
('Tata', 'Harrier', 2022, 'SUV', 16, 1500000.00, 'White', 'available'),
('Mahindra', 'Thar', 2021, 'SUV', 15, 2000000.00, 'Black', 'available'),
('Honda', 'Amaze', 2020, 'Sedan', 18, 800000.00, 'Silver', 'available'),
('Toyota', 'Fortuner', 2023, 'SUV', 12, 3000000.00, 'Grey', 'available'),
('Ford', 'Endeavour', 2022, 'SUV', 10, 3500000.00, 'Orange', 'available');

SELECT * from vehiclefeatures;

TRUNCATE TABLE vehiclefeatures ;

-- Maruti Suzuki Swift
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Air Conditioning', 'Automatic climate control' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Power Steering', 'Electric power steering' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Power Windows', 'Power windows with one-touch up/down' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';

-- Hyundai i20
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ABS', 'Anti-lock Braking System' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Airbags', 'Driver and passenger airbags' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';

-- Tata Nexon
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Navigation System', 'Built-in GPS navigation system' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bluetooth Connectivity', 'Bluetooth hands-free connectivity' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Camera', 'Rear parking camera' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';

-- Mahindra XUV500
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Cruise Control', 'Adaptive cruise control' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Keyless Entry', 'Keyless entry with push-button start' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Leather Seats', 'Premium leather upholstery' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';

-- Honda City
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Honda' AND model = 'City';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Seats', 'Heated front seats' FROM Vehicle WHERE make = 'Honda' AND model = 'City';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Parking Sensors', 'Front and rear parking sensors' FROM Vehicle WHERE make = 'Honda' AND model = 'City';

-- Toyota Innova
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Entertainment System', 'Rear seat entertainment system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Blind Spot Monitoring', 'Blind spot monitoring system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Lane Departure Warning', 'Lane departure warning system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';

-- Ford EcoSport
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Apple CarPlay', 'Apple CarPlay integration' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Android Auto', 'Android Auto integration' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Voice Control', 'Voice control system' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';

-- Renault Kwid
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Touchscreen Infotainment', 'Touchscreen infotainment system' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Reverse Parking Camera', 'Reverse parking camera' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Digital Instrument Cluster', 'Digital instrument cluster' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';

-- Nissan Magnite
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '360-Degree Camera', '360-degree camera system' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Wireless Charging', 'Wireless phone charging' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Ambient Lighting', 'Ambient interior lighting' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';

-- Volkswagen Polo
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rain Sensing Wipers', 'Rain sensing windshield wipers' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Automatic Headlights', 'Automatic headlights' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Mirrors', 'Heated side mirrors' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';

-- Skoda Rapid
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Leather Seats', 'Premium leather upholstery' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear AC Vents', 'Rear air conditioning vents' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';

-- Kia Seltos
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heads-Up Display', 'Heads-up display' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bose Sound System', 'Bose premium sound system' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Ventilated Seats', 'Ventilated front seats' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';

-- MG Hector
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Panoramic Sunroof', 'Panoramic sunroof' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Internet Inside', 'Internet connectivity inside the car' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Voice Assistant', 'Voice assistant for car controls' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';

-- Jeep Compass
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '4x4 Drive', 'Four-wheel drive system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Hill Descent Control', 'Hill descent control system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Terrain Management', 'Terrain management system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';

-- Fiat Punto
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Dual Airbags', 'Driver and passenger dual airbags' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ABS with EBD', 'Anti-lock Braking System with Electronic Brakeforce Distribution' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Defogger', 'Rear window defogger' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';

-- Mitsubishi Pajero
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '4WD', 'Four-wheel drive system' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rockford Sound System', 'Rockford premium sound system' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Spoiler', 'Rear spoiler for improved aerodynamics' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';

-- Isuzu D-Max
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Cargo Bed Liner', 'Durable cargo bed liner' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Tow Hitch', 'Factory-installed tow hitch' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Off-Road Tires', 'All-terrain off-road tires' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';

-- Datsun Go
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Follow Me Home Headlamps', 'Headlamps stay on for a while after locking the car' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Dual Front Airbags', 'Driver and passenger front airbags' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Wiper', 'Rear windshield wiper' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';

-- Lexus ES
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Mark Levinson Audio', 'Mark Levinson premium audio system' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Cruise Control', 'Adaptive cruise control system' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated and Ventilated Seats', 'Heated and ventilated front seats' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';

-- Jaguar XF
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Meridian Sound System', 'Meridian premium sound system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Gesture Control', 'Gesture control for infotainment system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Dynamics', 'Adaptive dynamics system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';

-- Land Rover Discovery
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Terrain Response', 'Terrain response system' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Wade Sensing', 'Wade sensing system for water fording' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'All-Terrain Progress Control', 'All-terrain progress control system' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';

-- Volvo XC90
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Pilot Assist', 'Pilot assist semi-autonomous driving system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'City Safety', 'City safety collision avoidance system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bowers & Wilkins Audio', 'Bowers & Wilkins premium audio system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';

-- Porsche Cayenne
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Porsche Dynamic Chassis Control', 'Dynamic chassis control system' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sport Chrono Package', 'Sport chrono package with performance enhancements' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Air Suspension', 'Adaptive air suspension system' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';

-- Ferrari 488
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Ceramic Brakes', 'High-performance carbon ceramic brakes' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Launch Control', 'Launch control system for rapid acceleration' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Magnetorheological Suspension', 'Advanced magnetorheological suspension system' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';

-- Lamborghini Huracan
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Lamborghini Dynamic Steering', 'Dynamic steering system' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ANIMA Driving Modes', 'ANIMA driving mode selector' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Fiber Interior', 'Carbon fiber interior trim' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';

-- Bentley Bentayga
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Naim Audio System', 'Naim premium audio system' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Mulliner Driving Specification', 'Mulliner driving specification package' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Seat Entertainment', 'Rear seat entertainment system' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';

-- Rolls Royce Ghost
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Starlight Headliner', 'Starlight headliner with fiber optic lights' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Coach Doors', 'Rear-hinged coach doors' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Spirit of Ecstasy', 'Illuminated Spirit of Ecstasy hood ornament' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';

-- Aston Martin DB11
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Aston Martin Premium Audio', 'Premium audio system' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Damping System', 'Adaptive damping suspension system' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Steering Wheel', 'Heated steering wheel' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';

-- Maserati Ghibli
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Harman Kardon Audio', 'Harman Kardon premium audio system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Skyhook Suspension', 'Skyhook adaptive suspension system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Soft Close Doors', 'Soft close door system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';

-- Bugatti Chiron
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Quad Turbocharged Engine', 'Quad turbocharged W16 engine' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Top Speed Key', 'Top speed key for unlocking maximum speed' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Fiber Body', 'Full carbon fiber body' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';

-- Pagani Huayra
-- Maruti Suzuki Swift
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Air Conditioning', 'Automatic climate control' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Power Steering', 'Electric power steering' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Power Windows', 'Power windows with one-touch up/down' FROM Vehicle WHERE make = 'Maruti Suzuki' AND model = 'Swift';

-- Hyundai i20
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ABS', 'Anti-lock Braking System' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Airbags', 'Driver and passenger airbags' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Hyundai' AND model = 'i20';

-- Tata Nexon
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Navigation System', 'Built-in GPS navigation system' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bluetooth Connectivity', 'Bluetooth hands-free connectivity' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Camera', 'Rear parking camera' FROM Vehicle WHERE make = 'Tata' AND model = 'Nexon';

-- Mahindra XUV500
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Cruise Control', 'Adaptive cruise control' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Keyless Entry', 'Keyless entry with push-button start' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Leather Seats', 'Premium leather upholstery' FROM Vehicle WHERE make = 'Mahindra' AND model = 'XUV500';

-- Honda City
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Honda' AND model = 'City';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Seats', 'Heated front seats' FROM Vehicle WHERE make = 'Honda' AND model = 'City';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Parking Sensors', 'Front and rear parking sensors' FROM Vehicle WHERE make = 'Honda' AND model = 'City';

-- Toyota Innova
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Entertainment System', 'Rear seat entertainment system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Blind Spot Monitoring', 'Blind spot monitoring system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Lane Departure Warning', 'Lane departure warning system' FROM Vehicle WHERE make = 'Toyota' AND model = 'Innova';

-- Ford EcoSport
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Apple CarPlay', 'Apple CarPlay integration' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Android Auto', 'Android Auto integration' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Voice Control', 'Voice control system' FROM Vehicle WHERE make = 'Ford' AND model = 'EcoSport';

-- Renault Kwid
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Touchscreen Infotainment', 'Touchscreen infotainment system' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Reverse Parking Camera', 'Reverse parking camera' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Digital Instrument Cluster', 'Digital instrument cluster' FROM Vehicle WHERE make = 'Renault' AND model = 'Kwid';

-- Nissan Magnite
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '360-Degree Camera', '360-degree camera system' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Wireless Charging', 'Wireless phone charging' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Ambient Lighting', 'Ambient interior lighting' FROM Vehicle WHERE make = 'Nissan' AND model = 'Magnite';

-- Volkswagen Polo
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rain Sensing Wipers', 'Rain sensing windshield wipers' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Automatic Headlights', 'Automatic headlights' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Mirrors', 'Heated side mirrors' FROM Vehicle WHERE make = 'Volkswagen' AND model = 'Polo';

-- Skoda Rapid
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sunroof', 'Electric sunroof' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Leather Seats', 'Premium leather upholstery' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear AC Vents', 'Rear air conditioning vents' FROM Vehicle WHERE make = 'Skoda' AND model = 'Rapid';

-- Kia Seltos
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heads-Up Display', 'Heads-up display' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bose Sound System', 'Bose premium sound system' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Ventilated Seats', 'Ventilated front seats' FROM Vehicle WHERE make = 'Kia' AND model = 'Seltos';

-- MG Hector
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Panoramic Sunroof', 'Panoramic sunroof' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Internet Inside', 'Internet connectivity inside the car' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Voice Assistant', 'Voice assistant for car controls' FROM Vehicle WHERE make = 'MG' AND model = 'Hector';

-- Jeep Compass
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '4x4 Drive', 'Four-wheel drive system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Hill Descent Control', 'Hill descent control system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Terrain Management', 'Terrain management system' FROM Vehicle WHERE make = 'Jeep' AND model = 'Compass';

-- Fiat Punto
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Dual Airbags', 'Driver and passenger dual airbags' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ABS with EBD', 'Anti-lock Braking System with Electronic Brakeforce Distribution' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Defogger', 'Rear window defogger' FROM Vehicle WHERE make = 'Fiat' AND model = 'Punto';

-- Mitsubishi Pajero
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, '4WD', 'Four-wheel drive system' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rockford Sound System', 'Rockford premium sound system' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Spoiler', 'Rear spoiler for improved aerodynamics' FROM Vehicle WHERE make = 'Mitsubishi' AND model = 'Pajero';

-- Isuzu D-Max
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Cargo Bed Liner', 'Durable cargo bed liner' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Tow Hitch', 'Factory-installed tow hitch' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Off-Road Tires', 'All-terrain off-road tires' FROM Vehicle WHERE make = 'Isuzu' AND model = 'D-Max';

-- Datsun Go
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Follow Me Home Headlamps', 'Headlamps stay on for a while after locking the car' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Dual Front Airbags', 'Driver and passenger front airbags' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Wiper', 'Rear windshield wiper' FROM Vehicle WHERE make = 'Datsun' AND model = 'Go';

-- Lexus ES
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Mark Levinson Audio', 'Mark Levinson premium audio system' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Cruise Control', 'Adaptive cruise control system' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated and Ventilated Seats', 'Heated and ventilated front seats' FROM Vehicle WHERE make = 'Lexus' AND model = 'ES';

-- Jaguar XF
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Meridian Sound System', 'Meridian premium sound system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Gesture Control', 'Gesture control for infotainment system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Dynamics', 'Adaptive dynamics system' FROM Vehicle WHERE make = 'Jaguar' AND model = 'XF';

-- Land Rover Discovery
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Terrain Response', 'Terrain response system' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Wade Sensing', 'Wade sensing system for water fording' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'All-Terrain Progress Control', 'All-terrain progress control system' FROM Vehicle WHERE make = 'Land Rover' AND model = 'Discovery';

-- Volvo XC90
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Pilot Assist', 'Pilot assist semi-autonomous driving system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'City Safety', 'City safety collision avoidance system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Bowers & Wilkins Audio', 'Bowers & Wilkins premium audio system' FROM Vehicle WHERE make = 'Volvo' AND model = 'XC90';

-- Porsche Cayenne
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Porsche Dynamic Chassis Control', 'Dynamic chassis control system' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Sport Chrono Package', 'Sport chrono package with performance enhancements' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Air Suspension', 'Adaptive air suspension system' FROM Vehicle WHERE make = 'Porsche' AND model = 'Cayenne';

-- Ferrari 488
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Ceramic Brakes', 'High-performance carbon ceramic brakes' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Launch Control', 'Launch control system for rapid acceleration' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Magnetorheological Suspension', 'Advanced magnetorheological suspension system' FROM Vehicle WHERE make = 'Ferrari' AND model = '488';

-- Lamborghini Huracan
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Lamborghini Dynamic Steering', 'Dynamic steering system' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'ANIMA Driving Modes', 'ANIMA driving mode selector' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Fiber Interior', 'Carbon fiber interior trim' FROM Vehicle WHERE make = 'Lamborghini' AND model = 'Huracan';

-- Bentley Bentayga
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Naim Audio System', 'Naim premium audio system' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Mulliner Driving Specification', 'Mulliner driving specification package' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Rear Seat Entertainment', 'Rear seat entertainment system' FROM Vehicle WHERE make = 'Bentley' AND model = 'Bentayga';

-- Rolls Royce Ghost
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Starlight Headliner', 'Starlight headliner with fiber optic lights' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Coach Doors', 'Rear-hinged coach doors' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Spirit of Ecstasy', 'Illuminated Spirit of Ecstasy hood ornament' FROM Vehicle WHERE make = 'Rolls Royce' AND model = 'Ghost';

-- Aston Martin DB11
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Aston Martin Premium Audio', 'Premium audio system' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Adaptive Damping System', 'Adaptive damping suspension system' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Heated Steering Wheel', 'Heated steering wheel' FROM Vehicle WHERE make = 'Aston Martin' AND model = 'DB11';

-- Maserati Ghibli
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Harman Kardon Audio', 'Harman Kardon premium audio system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Skyhook Suspension', 'Skyhook adaptive suspension system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Soft Close Doors', 'Soft close door system' FROM Vehicle WHERE make = 'Maserati' AND model = 'Ghibli';

-- Bugatti Chiron
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Quad Turbocharged Engine', 'Quad turbocharged W16 engine' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Top Speed Key', 'Top speed key for unlocking maximum speed' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';
INSERT INTO VehicleFeatures (VID, feature_name, description)
SELECT VID, 'Carbon Fiber Body', 'Full carbon fiber body' FROM Vehicle WHERE make = 'Bugatti' AND model = 'Chiron';

INSERT INTO TestDrive (CID, VID, schedule, status)
SELECT 
    c.CID, 
    v.VID, 
    DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * 30) DAY) AS schedule,  -- Random date within the next 30 days
    'pending' AS status
FROM 
    Customer c
JOIN 
    Vehicle v
ON 
    c.CID % 10 = v.VID % 10  -- Simple join condition to create combinations
LIMIT 60;  -- Limit to 60 entries

SELECT * from testdrive;

INSERT INTO Service (CID, VID, details, status)
SELECT 
    c.CID, 
    v.VID, 
    'Routine maintenance service', 
    'requested'
FROM 
    Customer c
JOIN 
    Vehicle v
ON 
    c.CID % 10 = v.VID % 10  -- Simple join condition to create combinations
LIMIT 30;  -- Limit to 30 entries

SELECT * FROM Service;

INSERT INTO Review (CID, rating, review_text, review_date)
SELECT 
    c.CID, 
    FLOOR(1 + (RAND() * 5)) AS rating,  -- Random rating between 1 and 5
    CASE 
        WHEN RAND() < 0.2 THEN 'Excellent service and great vehicle quality!'
        WHEN RAND() < 0.4 THEN 'Very satisfied with the purchase experience.'
        WHEN RAND() < 0.6 THEN 'Good value for money, but delivery was delayed.'
        WHEN RAND() < 0.8 THEN 'Average experience, expected better customer service.'
        ELSE 'Not satisfied with the vehicle performance.'
    END AS review_text,  -- Different review texts
    CURDATE() AS review_date
FROM 
    Customer c
LEFT JOIN 
    Review r ON c.CID = r.CID
WHERE 
    r.CID IS NULL  -- Ensure only one review per customer
LIMIT 30;  -- Limit to 30 entries


SELECT * FROM review;



INSERT INTO PreOwned (VID, previous_owner, vehicle_condition, resale_price)
SELECT 
    v.VID, 
    CASE 
        WHEN RAND() < 0.1 THEN 'Amit Sharma'
        WHEN RAND() < 0.2 THEN 'Priya Verma'
        WHEN RAND() < 0.3 THEN 'Rajesh Kumar'
        WHEN RAND() < 0.4 THEN 'Sneha Iyer'
        WHEN RAND() < 0.5 THEN 'Vikram Singh'
        WHEN RAND() < 0.6 THEN 'Suresh Reddy'
        WHEN RAND() < 0.7 THEN 'Anjali Das'
        WHEN RAND() < 0.8 THEN 'Karan Mehta'
        WHEN RAND() < 0.9 THEN 'Meena Das'
        ELSE 'Arun Nair'
    END AS previous_owner,  -- Different previous owner names
    CASE 
        WHEN RAND() < 0.25 THEN 'excellent'
        WHEN RAND() < 0.50 THEN 'good'
        WHEN RAND() < 0.75 THEN 'fair'
        ELSE 'poor'
    END AS vehicle_condition,  -- Random vehicle condition
    ROUND(v.price * (0.5 + (RAND() * 0.5)), 2) AS resale_price  -- Random resale price between 50% and 100% of original price
FROM 
    Vehicle v
ORDER BY 
    RAND()  -- Randomly select vehicles
LIMIT 30;  -- Limit to 30 entries

SELECT * FROM PreOwned;


INSERT INTO Parts (name, supplier, stock, price) VALUES
('Brake Pads', 'Bosch', 100, 1500.00),
('Air Filter', 'Mann-Filter', 200, 500.00),
('Oil Filter', 'Fram', 150, 300.00),
('Spark Plug', 'NGK', 250, 200.00),
('Battery', 'Exide', 50, 5000.00),
('Headlight Bulb', 'Philips', 100, 800.00),
('Windshield Wiper', 'Bosch', 200, 400.00),
('Radiator', 'Denso', 30, 7000.00),
('Alternator', 'Bosch', 20, 12000.00),
('Fuel Pump', 'Delphi', 40, 6000.00),
('Clutch Kit', 'Sachs', 25, 8000.00),
('Timing Belt', 'Gates', 50, 2500.00),
('Water Pump', 'Aisin', 30, 4500.00),
('Shock Absorber', 'Monroe', 60, 3500.00),
('Exhaust Muffler', 'Walker', 40, 5500.00),
('Brake Disc', 'Brembo', 70, 4000.00),
('Steering Wheel', 'Momo', 20, 7000.00),
('Gearbox', 'ZF', 10, 15000.00),
('Turbocharger', 'Garrett', 15, 20000.00),
('Catalytic Converter', 'MagnaFlow', 25, 10000.00),
('Radiator Hose', 'Gates', 100, 600.00),
('Brake Caliper', 'Brembo', 30, 9000.00),
('Fuel Injector', 'Bosch', 50, 3000.00),
('Engine Mount', 'Anchor', 40, 2500.00),
('Control Arm', 'Moog', 30, 4000.00),
('Oxygen Sensor', 'Denso', 60, 2000.00),
('Throttle Body', 'Bosch', 20, 8000.00),
('EGR Valve', 'Delphi', 25, 5000.00),
('Mass Air Flow Sensor', 'Bosch', 30, 6000.00),
('Ignition Coil', 'Delphi', 50, 3000.00);

SELECT * FROM Parts;


INSERT INTO Orders (CID, VID, order_date, status, total_amount)
SELECT 
    c.CID, 
    v.VID, 
    CURDATE() AS order_date,  -- Current date as order date
    'pending' AS status,  -- Default status
    v.price AS total_amount  -- Total amount based on vehicle price
FROM 
    Customer c
JOIN 
    Vehicle v
ON 
    c.CID % 10 = v.VID % 10  -- Simple join condition to create combinations
ORDER BY 
    RAND()  -- Randomly select combinations
LIMIT 30;  -- Limit to 30 entries

SELECT * FROM Orders;


SELECT 
    (SELECT COUNT(*) FROM User) +
    (SELECT COUNT(*) FROM Customer) +
    (SELECT COUNT(*) FROM Vehicle) +
    (SELECT COUNT(*) FROM TestDrive) +
    (SELECT COUNT(*) FROM Service) +
    (SELECT COUNT(*) FROM Insurance) +
    (SELECT COUNT(*) FROM Orders) +
    (SELECT COUNT(*) FROM Invoice) +
    (SELECT COUNT(*) FROM Parts) +
    (SELECT COUNT(*) FROM Dealership) +
    (SELECT COUNT(*) FROM PreOwned) +
    (SELECT COUNT(*) FROM VehicleFeatures) +
    (SELECT COUNT(*) FROM Review) +
    (SELECT COUNT(*) FROM Booking) +
    (SELECT COUNT(*) FROM Employee) AS total_rows;


select * from parts


INSERT INTO Invoice (OID, amount, payment_method, status, invoice_date)
SELECT 
    o.OID, 
    o.total_amount AS amount, 
    CASE 
        WHEN RAND() < 0.33 THEN 'cash'
        WHEN RAND() < 0.66 THEN 'credit card'
        ELSE 'online'
    END AS payment_method,  -- Random payment method
    'pending' AS status,  -- Default status
    CURDATE() AS invoice_date  -- Current date as invoice date
FROM 
    Orders o
ORDER BY 
    RAND()  -- Randomly select orders
LIMIT 30;  -- Limit to 30 entries

SELECT * FROM Invoice;


INSERT INTO Insurance (VID, policy_number, provider, start_date, end_date, coverage_details)
SELECT 
    v.VID, 
    CONCAT('POL', LPAD(FLOOR(RAND() * 1000000), 6, '0')) AS policy_number,  -- Random policy number
    CASE 
        WHEN RAND() < 0.2 THEN 'ICICI Lombard'
        WHEN RAND() < 0.4 THEN 'HDFC Ergo'
        WHEN RAND() < 0.6 THEN 'Bajaj Allianz'
        WHEN RAND() < 0.8 THEN 'Tata AIG'
        ELSE 'Reliance General'
    END AS provider,  -- Random provider
    CURDATE() AS start_date,  -- Current date as start date
    DATE_ADD(CURDATE(), INTERVAL 1 YEAR) AS end_date,  -- One year from start date as end date
    'Comprehensive coverage including third-party liability and own damage' AS coverage_details
FROM 
    Vehicle v
ORDER BY 
    RAND()  -- Randomly select vehicles
LIMIT 100;  -- Limit to 100 entries

SELECT * FROM Insurance;



select * from booking;

INSERT INTO Booking (CID, VID, booking_date, status)
SELECT 
    c.CID, 
    v.VID, 
    CURDATE() AS booking_date,  -- Current date as booking date
    'pending' AS status  -- Default status
FROM 
    Customer c
JOIN 
    Vehicle v
ON 
    c.CID % 10 = v.VID % 10  -- Simple join condition to create combinations
ORDER BY 
    RAND()  -- Randomly select combinations
LIMIT 30;  -- Limit to 30 entries

SELECT * FROM `user`;


SELECT * FROM User WHERE role = 'admin';

select * from service;
desc booking;



SELECT CID FROM Customer WHERE UID = 1;

select * from customer;
select cid from customer where `UID`=89
;

SHOW tableS;

SHOW TABLES LIKE 'Booking';


select * from user;


show TABLEs;
