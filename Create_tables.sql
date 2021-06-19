CREATE DATABASE WRA_Data;
USE WRA_Data;

CREATE TABLE LttReturn (
	   LttReturnId varchar(12) NOT NULL,
	   CaseReference varchar(12) NOT NULL,
	   LttSellerId varchar(12) NOT NULL,
	   LttBuyerId varchar(12) NOT NULL,
	   LttAboutTheLandSectionId varchar(12) NOT NULL,
	   LttAboutTheTransactionSectionId varchar(12) NOT NULL,
	   PRIMARY KEY(LttReturnId)
);

CREATE TABLE LttOrganisation (
	   LttOrganisationId varchar(12) NOT NULL,
	   AddressLine1 varchar(100) NOT NULL,
	   AddressLine2 varchar(100) NOT NULL,
	   AddressLine3 varchar(50),
	   AddressLine4 varchar(50),
	   Country varchar(50) NOT NULL,
	   LttUniqueIdentifierId varchar(12) NOT NULL,
	   Name varchar(60) NOT NULL,
	   Postcode varchar(10) NOT NULL,
	   TelephoneNumber varchar(15) NOT NULL,
	   TradingName varchar(60),
	   IsVatRegistered boolean NOT NULL DEFAULT 1,
	   VatRegistrationNumber varchar(15) NOT NULL,
	   IsOrganisationBasedInTheUK boolean NOT NULL DEFAULT 1,
	   UPRN varchar(12) NOT NULL,
	   PRIMARY KEY(LttOrganisationId)
);

CREATE TABLE LttIndividual (
	   LttIndividualId varchar(12) NOT NULL,
  	   AddressLine1 varchar(100) NOT NULL,
	   AddressLine2 varchar(100) NOT NULL,
	   AddressLine3 varchar(50),
	   AddressLine4 varchar(50),
	   Country varchar(50) NOT NULL,
	   DateOfBirth varchar(10) NOT NULL,
	   FirstName varchar(40) NOT NULL,
	   LastName varchar(40) NOT NULL,
	   LttUniqueIdentifierId varchar(12) NOT NULL,
   	   Postcode varchar(10) NOT NULL,
  	   TelephoneNumber varchar(15) NOT NULL,
	   OtherTitle varchar(20),
	   TitleTypeId varchar(1),
   	   UPRN varchar(12) NOT NULL,
	   PRIMARY KEY(LttIndividualId)
);

CREATE TABLE LttSeller (
	   LttSellerId varchar(12) NOT NULL,
	   IsOrganisation boolean NOT NULL DEFAULT 1,
	   LttIndividualId varchar(12) NOT NULL,
	   LttOrganisationId varchar(12) NOT NULL,
	   LttReturnId varchar(12) NOT NULL,
	   SellerAgentId varchar(12) NOT NULL,
	   PRIMARY KEY (LttSellerId)
);

CREATE TABLE LttBuyer (
	   LttBuyerId varchar(12) NOT NULL,
	   BuyerIsIndividual boolean NOT NULL DEFAULT 0,
	   IsConnectedToSeller boolean NOT NULL DEFAULT 0,
	   IsTrustee boolean NOT NULL DEFAULT 0,
	   LttIndividualId varchar(12) NOT NULL,
	   LttOrganisationId varchar(12) NOT NULL,
	   LttReturnId varchar(12) NOT NULL,
	   PRIMARY KEY(LttBuyerId)
);

CREATE TABLE LttAboutTheLandSection (
	   LttAboutTheLandSectionId varchar(12) NOT NULL,
   	   AddressLine1 varchar(100) NOT NULL,
	   AddressLine2 varchar(100) NOT NULL,
	   AddressLine3 varchar(50),
	   AddressLine4 varchar(50),
	   Country varchar(50) NOT NULL,
	   ExchangedAddressLine1 varchar(100) NOT NULL,
   	   ExchangedAddressLine2 varchar(100) NOT NULL,
   	   ExchangedAddressLine3 varchar(50),
   	   ExchangedAddressLine4 varchar(50),
	   ExchangedCountry varchar(20) NOT NULL,
	   ExchangedPostcode varchar(12) NOT NULL,
	   LocalAuthority varchar(20) NOT NULL,
	   Postcode varchar(12) NOT NULL,
	   TitleNumber varchar(4) NOT NULL,
	   TotalConsiderationForTitle varchar(5) NOT NULL,
   	   UPRN varchar(12) NOT NULL,
	   PRIMARY KEY(LttAboutTheLandSectionId)
);

CREATE TABLE LttAboutTheTransactionSection (
	   LttAboutTheTransactionSectionId varchar(12) NOT NULL,
	   ChangeableAmountAfterRelief varchar(5) NOT NULL,
	   DateOfContract varchar(10) NOT NULL,
	   IsClaimingTaxRelief boolean NOT NULL DEFAULT 0,
	   PRIMARY KEY(LttAboutTheTransactionSectionId)
);

CREATE TABLE LttTransactionTaxRelief (
	   LttTransactionTaxReliefId varchar(12) NOT NULL,
	   LttAboutTheTransactionSectionId varchar(12) NOT NULL,
	   LttTaxReliefTypeId varchar(12) NOT NULL,
	   PRIMARY KEY (LttTransactionTaxReliefId)
);

CREATE TABLE LttTaxReliefType (
	   LttTaxReliefTypeId varchar(12) NOT NULL,
	   Name varchar(60) NOT NULL,
	   PRIMARY KEY(LttTaxReliefTypeId)
);
