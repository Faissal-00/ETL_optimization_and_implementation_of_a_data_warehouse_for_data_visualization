use [ECommerceSource-2023-8-31-9-17]

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ECom';

select * from ECom


use EcomDW


CREATE VIEW Utilisateurs AS
SELECT
    Age,
    Gender,
    City,
    Country,
    UserSignUpDate,
    UserLastPurchaseDate,
    UserStatus,
    UserTotalPurchases,
    UserSegment,
    UserSourceType,
    UserLastLoginDate,
    DatePurchaseDIM.DatePurchase,
    UserPurchaseFrequency,
    ReSignUpDelay,
    SIgnUpPurchaseDelay
FROM UserDIM
INNER JOIN GenderDIM ON UserDIM.GenderID = GenderDIM.GenderID
INNER JOIN CountryDIM ON UserDIM.CountryID = CountryDIM.CountryID
INNER JOIN CityDIM ON CountryDIM.CityID = CityDIM.CityID
INNER JOIN UserStatusDIM ON UserDIM.UserStatusID = UserStatusDIM.UserStatusID
INNER JOIN UserSegmentDIM ON UserDIM.UserSegmentID = UserSegmentDIM.UserSegmentID
INNER JOIN UserLocationDIM ON UserDIM.UserLocationID = UserLocationDIM.UserLocationID
INNER JOIN UserSourceTypeDIM ON UserDIM.UserSourceTypeID = UserSourceTypeDIM.UserSourceTypeID
INNER JOIN UserPurchaseFrequencyDIM ON UserDIM.UserPurchaseFrequencyID = UserPurchaseFrequencyDIM.UserPurchaseFrequencyID
INNER JOIN PurchasesFact on PurchasesFact.UserID=UserDIM.UserID
INNER JOIN DatePurchaseDIM on DatePurchaseDIM.DatePurchaseID=PurchasesFact.DatePurchaseID




CREATE VIEW Ventes AS
SELECT
    c.City,
    co.Country,
    p.ProductName,
    ccat.Category,
    scat.Subcategory,
    p.Price,
    pf.Quantity,
    dp.DatePurchase,
    pf.Rating
FROM PurchasesFact pf
INNER JOIN CityDIM c ON pf.UserID = c.CityID
INNER JOIN CountryDIM co ON pf.UserID = co.CountryID
INNER JOIN ProductDIM p ON pf.[ProductID] = p.[ProductID]
INNER JOIN CategoryDIM ccat ON p.[CategoryID] = ccat.[CategoryID]
INNER JOIN SubcategoryDIM scat ON p.[SubcategoryID] = scat.[SubcategoryID]
INNER JOIN DatePurchaseDIM dp ON pf.[DatePurchaseID] = dp.[DatePurchaseID];



SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Ventes';
