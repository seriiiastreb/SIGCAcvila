using System;
using System.Data;


public class DataObjects
{
    [Serializable]
    public class Client
    {
        int mClientID = 0;
        int mGender = 0;
        string mGender_String = string.Empty;
        bool mAllowDelete = false;
        string mFirstName = string.Empty;
        string mLastName = string.Empty;
        DateTime mBirthDate = DateTime.MinValue;
        string mClientPersonalID = string.Empty; 
        string mBuletinSeria = string.Empty;
        DateTime mDataEliberariiBuletin = DateTime.MinValue;
        DateTime mDataExpirariiBuletin = DateTime.MinValue;
        string mBuletinEliberatDe = string.Empty;           
        string mTelefonFix = string.Empty;
        string mTelefonMobil = string.Empty;          
        int mViza_Country = 0;
        string mViza_Country_String = string.Empty;
        int mViza_Raion = 0;
        string mViza_Raion_String = string.Empty;
        string mViza_Localitatea = string.Empty;
        string mViza_StradaAdresa = string.Empty;          
        string mEmail = string.Empty;
        int mSortGroup = 0;      
        string mSortGroup_String = string.Empty;

        public int ClientID
        {
            get { return mClientID; }
            set { mClientID = value; }
        }

        public bool AllowDelete
        {
            get { return mAllowDelete; }
        }

        public string FirstName
        {
            get { return mFirstName; }
            set { mFirstName = value; }
        }

        public string LastName
        {
            get { return mLastName; }
            set { mLastName = value; }
        }

        public DateTime BirthDate
        {
            get { return mBirthDate; }
            set { mBirthDate = value; }
        }
                      
        public string PersonalID
        {
            get { return mClientPersonalID; }
            set { mClientPersonalID = value; }
        }

        public int Gender
        {
            get { return mGender; }
            set { mGender = value; }
        }

        public string Gender_String
        {
            get { return mGender_String; }
            set { mGender_String = value; }
        }

        public string BuletinSeria
        {
            get { return mBuletinSeria; }
            set { mBuletinSeria = value; }
        }

        public DateTime DataEliberariiBuletin
        {
            get { return mDataEliberariiBuletin; }
            set { mDataEliberariiBuletin = value; }
        }

        public DateTime DataExpirariiBuletin
        {
            get { return mDataExpirariiBuletin; }
            set { mDataExpirariiBuletin = value; }
        }
        public string BuletinEliberatDe
        {
            get { return mBuletinEliberatDe; }
            set { mBuletinEliberatDe = value; }
        }

        public string TelefonFix
        {
            get { return mTelefonFix; }
            set { mTelefonFix = value; }
        }

        public string TelefonMobil
        {
            get { return mTelefonMobil; }
            set { mTelefonMobil = value; }
        }
                       
        public int Viza_Country
        {
            get { return mViza_Country; }
            set { mViza_Country = value; }
        }

        public string Viza_Country_String
        {
            get { return mViza_Country_String; }
            set { mViza_Country_String = value; }
        }

        public int Viza_Raion
        {
            get { return mViza_Raion; }
            set { mViza_Raion = value; }
        }

        public string Viza_Raion_String
        {
            get { return mViza_Raion_String; }
            set { mViza_Raion_String = value; }
        }

        public string Viza_Localitatea
        {
            get { return mViza_Localitatea; }
            set { mViza_Localitatea = value; }
        }

        public string Viza_StradaAdresa
        {
            get { return mViza_StradaAdresa; }
            set { mViza_StradaAdresa = value; }
        }          

        public string Email
        {
            get { return mEmail; }
            set { mEmail = value; }
        }
           
        public string SortGroup_String
        {
            get { return mSortGroup_String; }
            set { mSortGroup_String = value; }
        }

        public int SortGroup
        {
            get { return mSortGroup; }
            set { mSortGroup = value; }
        }

        //DateTime mActivationDate = DateTime.MinValue;
        //public DateTime ActivationDate
        //{
        //    get { return mActivationDate; }
        //    set { mActivationDate = value; }
        //}

        //string mLastManager = string.Empty;
        //public string LastManager
        //{
        //    get { return mLastManager; }
        //    set { mLastManager = value; }
        //}

        //int mTotalLoansNumber = 0;
        //public int TotalLoansNumber
        //{
        //    get { return mTotalLoansNumber; }
        //    set { mTotalLoansNumber = value; }
        //}

        //decimal mLastLoanAmount = 0;
        //public decimal LastLoanAmount
        //{
        //    get { return mLastLoanAmount; }
        //    set { mLastLoanAmount = value; }
        //}

        //int mActiveLoans = 0;
        //public int ActiveLoans
        //{
        //    get { return mActiveLoans; }
        //    set { mActiveLoans = value; }
        //}

        //decimal mTotalProfits = 0;
        //public decimal TotalProfits
        //{
        //    get { return mTotalProfits; }
        //    set { mTotalProfits = value; }
        //}

        //decimal mActiveProfits = 0;
        //public decimal ActiveProfits
        //{
        //    get { return mActiveProfits; }
        //    set { mActiveProfits = value; }
        //}

        public Client()
        {
        }

        public Client(DataRow clientInfoRow)
        {
            if (clientInfoRow != null)
            {
                mClientID = clientInfoRow["clientID"] != System.DBNull.Value ? (int)clientInfoRow["clientID"] : 0;
                mAllowDelete = clientInfoRow["AllowDelete"] != System.DBNull.Value ? (bool)clientInfoRow["AllowDelete"] : false;
                mFirstName = clientInfoRow["FirstName"] != System.DBNull.Value ? (string)clientInfoRow["FirstName"] : string.Empty;
                mLastName = clientInfoRow["LastName"] != System.DBNull.Value ? (string)clientInfoRow["LastName"] : string.Empty;
                mBirthDate = clientInfoRow["DateOfBirth"] != System.DBNull.Value ? (DateTime)clientInfoRow["DateOfBirth"] : DateTime.MinValue;
                mClientPersonalID = clientInfoRow["personalID"] != System.DBNull.Value ? (string)clientInfoRow["personalID"] : string.Empty;
                mGender = clientInfoRow["gender"] != System.DBNull.Value ? (int)clientInfoRow["gender"] : 0;
                mGender_String = clientInfoRow["gender_string"] != System.DBNull.Value ? (string)clientInfoRow["gender_string"] : string.Empty;
                mBuletinSeria = clientInfoRow["buletinSeria"] != System.DBNull.Value ? (string)clientInfoRow["buletinSeria"] : string.Empty;
                mDataEliberariiBuletin = clientInfoRow["dataEliberarii"] != System.DBNull.Value ? (DateTime)clientInfoRow["dataEliberarii"] : DateTime.MinValue;
                mDataExpirariiBuletin = clientInfoRow["dataExpirarii"] != System.DBNull.Value ? (DateTime)clientInfoRow["dataExpirarii"] : DateTime.MinValue;
                mBuletinEliberatDe = clientInfoRow["eliberatDe"] != System.DBNull.Value ? (string)clientInfoRow["eliberatDe"] : string.Empty;
                mTelefonFix = clientInfoRow["telefonFix"] != System.DBNull.Value ? (string)clientInfoRow["telefonFix"] : string.Empty;
                mTelefonMobil = clientInfoRow["telefonMobil"] != System.DBNull.Value ? (string)clientInfoRow["telefonMobil"] : string.Empty;
                mViza_Country = clientInfoRow["viza_country"] != System.DBNull.Value ? (int)clientInfoRow["viza_country"] : 0;
                mViza_Country_String = clientInfoRow["viza_country_string"] != System.DBNull.Value ? (string)clientInfoRow["viza_country_string"] : string.Empty;
                mViza_Raion = clientInfoRow["viza_raion"] != System.DBNull.Value ? (int)clientInfoRow["viza_raion"] : 0;
                mViza_Raion_String = clientInfoRow["viza_raion_string"] != System.DBNull.Value ? (string)clientInfoRow["viza_raion_string"] : string.Empty;
                mViza_Localitatea = clientInfoRow["viza_localitatea"] != System.DBNull.Value ? (string)clientInfoRow["viza_localitatea"] : string.Empty;
                mViza_StradaAdresa = clientInfoRow["viza_stradaAdresa"] != System.DBNull.Value ? (string)clientInfoRow["viza_stradaAdresa"] : string.Empty;
                mEmail = clientInfoRow["email"] != System.DBNull.Value ? (string)clientInfoRow["email"] : string.Empty;
                mSortGroup_String = clientInfoRow["SortGroup_String"] != System.DBNull.Value ? (string)clientInfoRow["SortGroup_String"] : string.Empty;
                //mActivationDate = clientInfoRow["ActivationDate"] != System.DBNull.Value ? (DateTime)clientInfoRow["ActivationDate"] : DateTime.MinValue;
                //mLastManager = clientInfoRow["LastManager"] != System.DBNull.Value ? (string)clientInfoRow["LastManager"] : string.Empty;
                //mTotalLoansNumber = clientInfoRow["TotalLoansNumber"] != System.DBNull.Value ? (int)clientInfoRow["TotalLoansNumber"] : 0;
                //mLastLoanAmount = clientInfoRow["LastLoanAmount"] != System.DBNull.Value ? (decimal)clientInfoRow["LastLoanAmount"] : 0;
                //mActiveLoans = clientInfoRow["ActiveLoans"] != System.DBNull.Value ? (int)clientInfoRow["ActiveLoans"] : 0;
                //mTotalProfits = clientInfoRow["TotalProfits"] != System.DBNull.Value ? (decimal)clientInfoRow["TotalProfits"] : 0;
                //mActiveProfits = clientInfoRow["ActiveProfits"] != System.DBNull.Value ? (decimal)clientInfoRow["ActiveProfits"] : 0;

            }
        }


    }


    [Serializable]
    public class Order
    {
        int mOrder_ID = 0;
        public int Order_ID
        {
            get { return mOrder_ID; }
            set { mOrder_ID = value; }
        }

        int mState = 0;
        public int State
        {
            get { return mState; }
            set { mState = value; }
        }

        string mState_Name = string.Empty;
        public string State_Name
        {
            get { return mState_Name; }
            set { mState_Name = value; }
        }

        DateTime mDate = DateTime.MinValue;
        public DateTime Date
        {
            get { return mDate; }
            set { mDate = value; }
        }

        int mClient_ID = 0;
        public int Client_ID
        {
            get { return mClient_ID; }
            set { mClient_ID = value; }
        }

        string mClientDescription = string.Empty;
        public string ClientDescription
        {
            get { return mClientDescription; }
            set { mClientDescription = value; }
        }   

        int mNr = 0;
        public int Nr
        {
            get { return mNr; }
            set { mNr = value; }
        }            

      
        public Order()
        {
        }

        public Order(DataRow orderInfoRow)
        {
            if (orderInfoRow != null)
            {
                mOrder_ID = orderInfoRow["Order_ID"] != System.DBNull.Value ? (int)orderInfoRow["Order_ID"] : 0;
                mState = orderInfoRow["State"] != System.DBNull.Value ? (int)orderInfoRow["State"] : 0;
                mState_Name = orderInfoRow["State_Name"] != System.DBNull.Value ? (string)orderInfoRow["State_Name"] : string.Empty;
                mDate = orderInfoRow["Date"] != System.DBNull.Value ? (DateTime)orderInfoRow["Date"] : DateTime.MinValue;
                mClient_ID = orderInfoRow["Client_ID"] != System.DBNull.Value ? (int)orderInfoRow["Client_ID"] : 0;
                mNr = orderInfoRow["Nr"] != System.DBNull.Value ? (int)orderInfoRow["Nr"] : 0;
                mClientDescription = orderInfoRow["client_description"] != System.DBNull.Value ? (string)orderInfoRow["client_description"] : string.Empty;
            }
        }
    }

}

