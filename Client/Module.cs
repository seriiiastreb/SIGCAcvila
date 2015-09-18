﻿using System;
using System.Collections.Generic;
using System.Text;
using DAL;
using System.Collections;
using System.Data;

namespace Client
{
    public class Module
    {
        public const string ID = "Module Customers";
        public const string Description = "Processing data customer related (Personal Data; Orders)";
        public static readonly string DBConnectionsStringKey = "mainDBConnectionString";
        public static DataBridge mDataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Module.DBConnectionsStringKey), ConfigManager.GetProviderName(Module.DBConnectionsStringKey));

        private string Plus = string.Empty;

        string mLastError = string.Empty;
        public string LastError
        {
            get { return mLastError; }
        }

        public static void Register()
        {
            Security.Registrar.RegisterModule(ID, Description);
            Domains.CustomersPersonalData.Register();
            Domains.CustomersOrders.Register();
        }

        public Module()
        {
            Plus = Module.mDataBridge.ConcatSimbol + " ' ' " + Module.mDataBridge.ConcatSimbol;
        }

        #region Client Region

        public bool AddNewClient(ref DataObjects.Client clientObject)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                if (clientObject != null)
                {


                    string nonQuery = "INSERT INTO Client (gender,FirstName,LastName,           DateOfBirth,                                               personalID,    buletinSeria,                         dataEliberarii,                                                                                 dataExpirarii,                                                  eliberatDe,  telefonFix,  telefonMobil,   viza_country, viza_raion,  viza_localitatea,   viza_stradaAdresa,  email,  sortGroup)  "
                                + " OUTPUT INSERTED.ClientID "
                                + " VALUES (@gender, @FirstName, @LastName, " + (clientObject.BirthDate.Equals(EmptyDate) ? "NULL" : "@DateOfBirth") + ", @personalID, @buletinSeria, " + (clientObject.DataEliberariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataEliberarii") + ", " + (clientObject.DataExpirariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataExpirarii") + ", @eliberatDe, @telefonFix, @telefonMobil, @viza_country, @viza_raion,   @viza_localitatea, @viza_stradaAdresa, @email, @sortGroup ); ";

                    Hashtable parameters = new Hashtable();
                    parameters.Add("@FirstName", clientObject.FirstName);
                    parameters.Add("@LastName", clientObject.LastName);
                    if (!clientObject.BirthDate.Equals(EmptyDate)) parameters.Add("@DateOfBirth", clientObject.BirthDate);
                    parameters.Add("@personalID", clientObject.PersonalID);
                    parameters.Add("@gender", clientObject.Gender);
                    parameters.Add("@buletinSeria", clientObject.BuletinSeria);
                    if (!clientObject.DataEliberariiBuletin.Equals(EmptyDate)) parameters.Add("@dataEliberarii", clientObject.DataEliberariiBuletin);
                    if (!clientObject.DataExpirariiBuletin.Equals(EmptyDate)) parameters.Add("@dataExpirarii", clientObject.DataExpirariiBuletin);
                    parameters.Add("@eliberatDe", clientObject.BuletinEliberatDe);                  
                    parameters.Add("@telefonFix", clientObject.TelefonFix);
                    parameters.Add("@telefonMobil", clientObject.TelefonMobil);
                    parameters.Add("@viza_country", clientObject.Viza_Country);
                    parameters.Add("@viza_raion", clientObject.Viza_Raion);
                    parameters.Add("@viza_localitatea", clientObject.Viza_Localitatea);
                    parameters.Add("@viza_stradaAdresa", clientObject.Viza_StradaAdresa);                    
                    parameters.Add("@email", clientObject.Email);
                    parameters.Add("@sortGroup", clientObject.SortGroup);

                    object insertedID = mDataBridge.ExecuteScalarQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;

                    if (insertedID != null && !insertedID.ToString().Equals(string.Empty))
                    {
                        clientObject.ClientID = (int)insertedID;
                        result = true;
                    }
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateClient(DataObjects.Client clientObject)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                if (clientObject != null)
                {
                    string nonQuery = "UPDATE Client \r\n "
                    + " SET  \r\n "
                    + "   gender = @gender,\r\n "
                    + "   FirstName = @FirstName, \r\n "
                    + "   LastName = @LastName, \r\n "
                    + "   DateOfBirth = " + (clientObject.BirthDate.Equals(EmptyDate) ? "NULL" : "@DateOfBirth") + ", \r\n "
                    + "   personalID = @personalID,\r\n "                   
                    + "   buletinSeria = @buletinSeria,\r\n "
                    + "   dataEliberarii = " + (clientObject.DataEliberariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataEliberarii") + ",\r\n "
                    + "   dataExpirarii = " + (clientObject.DataExpirariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataExpirarii") + ",\r\n "
                    + "   eliberatDe = @eliberatDe,\r\n "
                    + "   telefonFix = @telefonFix,\r\n "
                    + "   telefonMobil = @telefonMobil,\r\n "
                    + "   viza_country = @viza_country,\r\n "
                    + "   viza_raion = @viza_raion,\r\n "
                    + "   viza_localitatea = @viza_localitatea,\r\n "
                    + "   viza_stradaAdresa = @viza_stradaAdresa,\r\n "                   
                    + "   email = @email,\r\n "
                    + "   sortGroup = @sortGroup\r\n "

                    + " WHERE \r\n "
                    + "   clientID = @clientID ";

                    Hashtable parameters = new Hashtable();
                    parameters.Add("@clientID", clientObject.ClientID);
                    parameters.Add("@FirstName", clientObject.FirstName);
                    parameters.Add("@LastName", clientObject.LastName);
                    if (!clientObject.BirthDate.Equals(EmptyDate)) parameters.Add("@DateOfBirth", clientObject.BirthDate);
                    parameters.Add("@personalID", clientObject.PersonalID);
                    parameters.Add("@gender", clientObject.Gender);
                    parameters.Add("@buletinSeria", clientObject.BuletinSeria);
                    if (!clientObject.DataEliberariiBuletin.Equals(EmptyDate)) parameters.Add("@dataEliberarii", clientObject.DataEliberariiBuletin);
                    if (!clientObject.DataExpirariiBuletin.Equals(EmptyDate)) parameters.Add("@dataExpirarii", clientObject.DataExpirariiBuletin);
                    parameters.Add("@eliberatDe", clientObject.BuletinEliberatDe);                                    
                    parameters.Add("@telefonFix", clientObject.TelefonFix);
                    parameters.Add("@telefonMobil", clientObject.TelefonMobil);
                    parameters.Add("@viza_country", clientObject.Viza_Country);
                    parameters.Add("@viza_raion", clientObject.Viza_Raion);
                    parameters.Add("@viza_localitatea", clientObject.Viza_Localitatea);
                    parameters.Add("@viza_stradaAdresa", clientObject.Viza_StradaAdresa);
                    parameters.Add("@email", clientObject.Email);
                    parameters.Add("@sortGroup", clientObject.SortGroup);

                    result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;       
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public DataTable GetClientList(int category, List<int> genderList, int parentClientID)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            string genderListSTR = Crypt.Utils.ConvertListToString(genderList);

            try
            {
                string query = "Select * "
                            + " , coalesce(firstName, '') " + Plus + " coalesce(lastName, '') as \"Client Full Name\" "
                            + " , (select Name From Classifiers Where Code = gender) as gender_string "
                            + " , (select Name From Classifiers Where Code = viza_country) as viza_country_string "
                            + " , (select Name From Classifiers Where Code = viza_raion) as viza_raion_string "
                            + " , coalesce(telefonMobil, '') " + Plus + " coalesce(telefonFix, '') as telefon "
                            + " , (select Name From Classifiers Where Code = SortGroup) as SortGroup_string "
                            //+ " , ( CASE WHEN (SELECT COUNT(*) FROM Loans WHERE Loans.clientID = client.ClientID) <> 0 THEN @NotAllowDelete ELSE @AllowDelete END ) as AllowDelete "

                            + " FROM CLIENT \r\n "
                            + " WHERE gender in (" + genderListSTR + ") "
                            + " AND parentClientID = " + parentClientID
                            + (category != 0 ? " AND sortGroup = " + category : string.Empty)
                            + " Order BY FirstName, LastName ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@AllowDelete", true);
                parameters.Add("@NotAllowDelete", false);

                result = mDataBridge.ExecuteQuery(query, parameters);
                mLastError = mDataBridge.LastError;

            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        public DataTable GetClientList(int category)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;
            
            try
            {
                string query = "Select * "
                            + " , coalesce(firstName, '') " + Plus + " (CASE WHEN gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN LastName ELSE '' END) as \"Client Full Name\" "                            
                            + " , (select Name From Classifiers Where Code = gender) as gender_string "
                            + " , (select Name From Classifiers Where Code = viza_country) as viza_country_string "
                            + " , (select Name From Classifiers Where Code = viza_raion) as viza_raion_string "
                            + " , coalesce(telefonMobil, '') " + Plus + " coalesce(telefonFix, '') as telefon "
                            + " , (select Name From Classifiers Where Code = SortGroup) as SortGroup_string "
                    //+ " , ( CASE WHEN (SELECT COUNT(*) FROM Loans WHERE Loans.clientID = client.ClientID) <> 0 THEN @NotAllowDelete ELSE @AllowDelete END ) as AllowDelete "

                            + " FROM CLIENT \r\n "
                            + (category != 0 ? " WHERE sortGroup = " + category : string.Empty)
                            + " Order BY FirstName, LastName ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@AllowDelete", true);
                parameters.Add("@NotAllowDelete", false);

                result = mDataBridge.ExecuteQuery(query, parameters);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
    

        public DataObjects.Client GetCleintObjectByID(int clientID)
        {
            DataObjects.Client clientObject = null;

            try
            {
                string query = "Select * \r\n "
                            + " , coalesce(firstName, '') " + Plus + " coalesce(lastName, '') as \"Client Full Name\"  \r\n "
                            + " , (select Name From Classifiers Where Code = gender) as gender_string  \r\n "
                            + " , (select Name From Classifiers Where Code = viza_country) as viza_country_string  \r\n "
                            + " , (select Name From Classifiers Where Code = viza_raion) as viza_raion_string \r\n  "
                            + " , coalesce(telefonMobil, '') " + Plus + " coalesce(telefonFix, '') as telefon  \r\n "
                            + " , (select Name From Classifiers Where Code = SortGroup) as SortGroup_string  \r\n "
                            + " , @AllowDelete as AllowDelete  \r\n "
                            //+ " , ( CASE WHEN (SELECT COUNT(*) FROM Loans WHERE Loans.clientID = client.ClientID) <> 0 THEN @NotAllowDelete ELSE @AllowDelete END ) as AllowDelete "

                            + " FROM Client \r\n  \r\n  "                 

                            + " WHERE  \r\n  "
                            + " Client.clientID = " + clientID + " \r\n ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@AllowDelete", true);
                parameters.Add("@NotAllowDelete", false);

                DataTable result = mDataBridge.ExecuteQuery(query, parameters);
                mLastError = mDataBridge.LastError;

                if (result != null && result.Rows.Count == 1)
                {
                    clientObject = new DataObjects.Client(result.Rows[0]);
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return clientObject;
        }
          
        public bool DeleteClient(int clientID)
        {
            bool result = false;
            try
            {
                string nonQuery = @"Delete FROM Client WHERE clientID = " + clientID;

                result = mDataBridge.ExecuteNonQuery(nonQuery); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool CheckExistClient(string firstName, string lastName, DateTime dateOfBirth)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"Select * FROM Client WHERE "
                                + "   firstName like '%" + firstName + "%' "
                                + " AND lastName like '%" + lastName + "%' "
                                + (!dateOfBirth.Equals(EmptyDate) ? " AND dateOfBirth = @dateBirth " : string.Empty);

                Hashtable parameters = new Hashtable();
                if (!dateOfBirth.Equals(EmptyDate)) parameters.Add("@dateBirth", dateOfBirth.Date);

                DataTable resultTable = mDataBridge.ExecuteQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;

                if (resultTable != null && resultTable.Rows.Count == 1)
                {
                    result = true;
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public int CheckExistClient(string idnp)
        {
            DateTime EmptyDate = DateTime.MinValue;

            int result = -1;

            try
            {
                string nonQuery = @"Select * FROM Client WHERE personalID = @idnp ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@idnp", idnp);

                DataTable resultTable = mDataBridge.ExecuteQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;

                if (resultTable != null && resultTable.Rows.Count == 1)
                {
                    result = resultTable.Rows[0]["ClientID"] != System.DBNull.Value ? (int)resultTable.Rows[0]["ClientID"] : -1;
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
 
        #endregion Client Region

        #region ClilentContracts

        public DataTable GetClientContractsList(int clientID)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string query = "SELECT \r\n "
                        + "   client_id,\r\n "
                        + "   contract_id,\r\n "
                        + "   contract_nr,\r\n "
                        + "   date_from,\r\n "
                        + "   date_to,\r\n "
                        + "   active\r\n "
                        + " FROM ClientContracts \r\n "
                        + " WHERE client_id = " + clientID;

                result = mDataBridge.ExecuteQuery(query);
                mLastError = mDataBridge.LastError;

            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        public bool AddClientContract(int client_id, string contract_nr, DateTime date_from, DateTime date_to, bool active)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {            
                string nonQuery = "INSERT INTO ClientContracts ( client_id,  contract_nr,  date_from,  date_to, active ) \r\n "
                    + " VALUES (  @client_id,  @contract_nr,  @date_from,  " + (!date_to.Equals(EmptyDate) ? "@date_to" : "NULL") + ",  @active ); ";
                           
                Hashtable parameters = new Hashtable();
                parameters.Add("@client_id", client_id);
                parameters.Add("@contract_nr", contract_nr);
                parameters.Add("@date_from", date_from);
                if (!date_to.Equals(EmptyDate)) parameters.Add("@date_to", date_to);
                parameters.Add("@active", active);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;               
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateClientContract(int client_id, int contract_id, string contract_nr, DateTime date_from, DateTime date_to, bool active)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = "UPDATE ClientContracts SET \r\n "
                    + " date_from = @date_from \r\n "
                    + " , date_to = " + (!date_to.Equals(EmptyDate) ? "@date_to" : "NULL") + " \r\n "
                    + " , active = @active \r\n "
                    + " WHERE client_id = @client_id \r\n "
                    + " AND contract_nr = @contract_nr ";
                           
                Hashtable parameters = new Hashtable();
                parameters.Add("@client_id", client_id);
                parameters.Add("@contract_id", contract_id);
                parameters.Add("@contract_nr", contract_nr);
                parameters.Add("@date_from", date_from);
                if (!date_to.Equals(EmptyDate)) parameters.Add("@date_to", date_to);
                parameters.Add("@active", active);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;               
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool DeleteClientContract(int client_id, int contract_id)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = "DELETE FROM ClientContracts  WHERE client_id = @client_id AND contract_id = @contract_id ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@client_id", client_id);
                parameters.Add("@contract_id", contract_id);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        #endregion ClilentContracts

        #region Customers Orders

//        public DataTable GetClientOrdersShortDetails()
//        {
//            DataTable result = new DataTable();
//            mLastError = string.Empty;

//            try
//            {
//                string query = @" WITH MainTBL as ( 
//                    Select order_id , 
//                    coalesce(Cl.FirstName,'') + CASE WHEN Cl.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + @" THEN ' ' + coalesce(Cl.LastName,'') ELSE '' END  as client_description
//                    FROM ClientOrders 
//                    LEFT JOIN Client as CL ON client_id = Cl.Clientid  ) 
//
//                    SELECT 
//                    MainTBL.order_id, 
//                    MainTBL.client_description,
//                    CO.nr as ""Nr"",  
//                    (SELECT Name from Classifiers Where Code = Co.state) as state_name, 
//                    CO.date,      
//                    SUM(OD.bucati) as ""Total Comandat"" ,
//                    0 as ""Total livrat"",
//                    0 as ""Diferenta""  
//
//                    FROM MainTBL  
//                    LEFT JOIN ClientOrders as CO ON CO.order_id = MainTBL.order_id 
//                    LEFT JOIN OrdersDetails as OD ON OD.order_id = MainTBL.order_id  
//                    GROUP BY MainTBL.order_id, MainTBL.client_description,  CO.nr , Co.state, CO.date
//                    ";       

//                result = mDataBridge.ExecuteQuery(query);
//                mLastError = mDataBridge.LastError;
//            }
//            catch (Exception exception)
//            {
//                mLastError += "Error using DataBridge. " + exception.Message;
//            }

//            return result;
//        }

//        public DataTable GetClientOrderFullDetails(int orderID)
//        {
//            DataTable result = new DataTable();
//            mLastError = string.Empty;

//            try
//            {
//                string query = @" 
//                          SELECT 
//                        order_id
//                        , articol
//                        , (Select name From Classifiers WHERE Code = articol) as articol_name
//                        , desen
//                        , (Select name From Classifiers WHERE Code = desen) as desen_name
//                        , tip
//                        , (Select name From Classifiers WHERE Code = tip) as tip_name
//                        , colorit
//                        , (Select name From Classifiers WHERE Code = colorit) as colorit_name
//                        , latime
//                        , lungime
//                        , metraj
//                        , bucati
//                        , festonare
//                        , (Select name From Classifiers WHERE Code = festonare) as festonare_name
//                        , ean13
//
//                         FROM  OrdersDetails as CO WHERE CO.order_id = " + orderID;       

//                result = mDataBridge.ExecuteQuery(query);
//                mLastError = mDataBridge.LastError;
//            }
//            catch (Exception exception)
//            {
//                mLastError += "Error using DataBridge. " + exception.Message;
//            }

//            return result;
//        }
        //public DataTable GetClientOrdersList()
        //{
        //    DataTable result = new DataTable();
        //    mLastError = string.Empty;

        //    try
        //    {
        //        string query = "SELECT \r\n "
        //                + "  order_id, \r\n "
        //                + "  state, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = state) as state_name , "
        //                + "  date, \r\n "
        //                + "  client_id, \r\n "
        //                + "  (Select Client.FirstName + (CASE WHEN Client.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN coalesce(Client.LastName,'') ELSE '' END) From Client WHERE Client.clientid = ClientOrders.client_id ) as client_description, "
        //                + "  nr, \r\n "
        //                + "  articol, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = articol) as articol_name , "
        //                + "  desen, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = desen) as desen_name , "
        //                + "  tip, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = tip) as tip_name , "
        //                + "  colorit, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as colorit_name , "
        //                + "  latime, \r\n "
        //                + "  lungime, \r\n "
        //                + "  metraj, \r\n "
        //                + "  bucati, \r\n "
        //                + "  festonare, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as festonare_name , "
        //                + "  ean13 \r\n "
        //                + "  FROM  \r\n "
        //                + "  ClientOrders \r\n ";

        //        result = mDataBridge.ExecuteQuery(query);
        //        mLastError = mDataBridge.LastError;
        //    }
        //    catch (Exception exception)
        //    {
        //        mLastError += "Error using DataBridge. " + exception.Message;
        //    }

        //    return result;
        //}

        //public DataTable GetClientOrdersList(int clientID)
        //{
        //    DataTable result = new DataTable();
        //    mLastError = string.Empty;

        //    try
        //    {
        //        string query = "SELECT \r\n "
        //                + "  order_id, \r\n "
        //                + "  state, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = state) as state_name , "
        //                + "  date, \r\n "
        //                + "  client_id, \r\n "
        //                + "  (Select Client.FirstName + (CASE WHEN Client.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN coalesce(Client.LastName,'') ELSE '' END) From Client WHERE Client.clientid = ClientOrders.client_id ) as client_description, "
        //                + "  nr, \r\n "
        //                + "  articol, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = articol) as articol_name , "
        //                + "  desen, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = desen) as desen_name , "
        //                + "  tip, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = tip) as tip_name , "
        //                + "  colorit, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as colorit_name , "
        //                + "  latime, \r\n "
        //                + "  lungime, \r\n "
        //                + "  metraj, \r\n "
        //                + "  bucati, \r\n "
        //                + "  festonare, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as festonare_name , "
        //                + "  ean13 \r\n "
        //                + "  FROM  \r\n "
        //                + "  ClientOrders \r\n "
        //                + " WHERE client_id = " + clientID;

        //        result = mDataBridge.ExecuteQuery(query);
        //        mLastError = mDataBridge.LastError;
        //    }
        //    catch (Exception exception)
        //    {
        //        mLastError += "Error using DataBridge. " + exception.Message;
        //    }

        //    return result;
        //}

        public DataTable GetClientOrdersList(int clientID, List<int> ordersState)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            string ordersStatesSTR = Crypt.Utils.ConvertListToString(ordersState);

            try
            {
                string query = "SELECT \r\n "
                        + "  order_id, \r\n "
                        + "  state, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = state) as state_name , "
                        + "  date, \r\n "
                        + "  client_id, \r\n "
                        + "  (Select Client.FirstName + (CASE WHEN Client.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN coalesce(Client.LastName,'') ELSE '' END) From Client WHERE Client.clientid = ClientOrders.client_id ) as client_description, "                      
                        + "  nr, \r\n "
                        + "  articol, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = articol) as articol_name , "
                        + "  desen, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = desen) as desen_name , "
                        + "  tip, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = tip) as tip_name , "
                        + "  colorit, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = colorit) as colorit_name , "
                        + "  latime, \r\n "
                        + "  lungime, \r\n "
                        + "  metraj, \r\n "
                        + "  bucati, \r\n "
                        + "  festonare, \r\n "
                        + "  (Select Name from Classifiers WHERE Code = colorit) as festonare_name , "
                        + "  ean13 \r\n "
                        + "  FROM  \r\n "
                        + "  ClientOrders \r\n "
                        + " WHERE client_id = " + clientID
                        + " AND state in (" + ordersStatesSTR + ")";

                result = mDataBridge.ExecuteQuery(query);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        //public DataObjects.Order GetOrderObjectByID(int orderID)
        //{
        //    DataObjects.Order resultObject = null;

        //    try
        //    {
        //        string query = "SELECT \r\n "
        //                + "  order_id, \r\n "
        //                + "  state, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = state) as state_name , "
        //                + "  date, \r\n "
        //                + "  client_id, \r\n "
        //                + "  (Select Client.FirstName + (CASE WHEN Client.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN coalesce(Client.LastName,'') ELSE '' END) From Client WHERE Client.clientid = ClientOrders.client_id ) as client_description, "
        //                + "  nr, \r\n "
        //                + "  articol, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = articol) as articol_name , "
        //                + "  desen, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = desen) as desen_name , "
        //                + "  tip, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = tip) as tip_name , "
        //                + "  colorit, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as colorit_name , "
        //                + "  latime, \r\n "
        //                + "  lungime, \r\n "
        //                + "  metraj, \r\n "
        //                + "  bucati, \r\n "
        //                + "  festonare, \r\n "
        //                + "  (Select Name from Classifiers WHERE Code = colorit) as festonare_name , "
        //                + "  ean13 \r\n "
        //                + "  FROM  \r\n "
        //                + "  ClientOrders \r\n "
        //                + " WHERE order_id = " + orderID;

        //        DataTable result = mDataBridge.ExecuteQuery(query);
        //        mLastError = mDataBridge.LastError;

        //        if (result != null && result.Rows.Count == 1)
        //            resultObject = new DataObjects.Order(result.Rows[0]);
        //    }
        //    catch (Exception exception)
        //    {
        //        mLastError += "Error using DataBridge. " + exception.Message;
        //    }

        //    return resultObject;
        //}
             
        public bool AddClientOrder(ref DataObjects.Order orderObject)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                if (orderObject != null)
                {
                    string nonQuery = "INSERT INTO ClientOrders(state,date,client_id,nr) \r\n"
                                    + " OUTPUT INSERTED.order_id "
                                    + " VALUES (@state,@date,@client_id,@nr); ";

                    Hashtable parameters = new Hashtable();
                    parameters.Add("@state", orderObject.State);
                    parameters.Add("@date", orderObject.Date);
                    parameters.Add("@client_id", orderObject.Client_ID);
                    parameters.Add("@nr", orderObject.Nr);
                  

                    object insertedID = mDataBridge.ExecuteScalarQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;

                    if (insertedID != null && !insertedID.ToString().Equals(string.Empty))
                    {
                        orderObject.Order_ID = (int)insertedID;
                        result = true;
                    }
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool UpdateClientOrder(DataObjects.Order orderObject)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                if (orderObject != null)
                {
                    string nonQuery = @"UPDATE 
                                          ClientOrders  
                                        SET 
                                          state = @state,
                                          date = @date,
                                          client_id = @client_id,
                                          nr = @nr                                          
                                        WHERE 
                                          order_id = @order_id; ";

                    Hashtable parameters = new Hashtable();
                    parameters.Add("@order_id", orderObject.Order_ID);
                    parameters.Add("@state", orderObject.State);
                    parameters.Add("@date", orderObject.Date);
                    parameters.Add("@client_id", orderObject.Client_ID);
                    parameters.Add("@nr", orderObject.Nr);                

                    result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;
                }
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public bool DeleteClientOrder(int orderID)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"DELETE FROM ClientOrders  WHERE order_id = " + orderID + "; ";                

                result = mDataBridge.ExecuteNonQuery(nonQuery); // PG compliant
                mLastError = mDataBridge.LastError;              
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        #endregion Customers Orders


        #region Customers Delivery Orders

        public DataTable GetDeliveryByID(int deliveryID)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string query = "SELECT \r\n "
                    + "  delivery_id,  \r\n "
                    + "  [date], \r\n "
                    + "  order_id, \r\n "
                    + "  quantity, \r\n "
                    + "  delivery_doc \r\n "
                    + "FROM OrdersDelivery  \r\n "
                    + " WHERE delivery_id = " + deliveryID;

                result = mDataBridge.ExecuteQuery(query);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public DataTable GetOrdersDeliveryList(int orderID)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string query = "SELECT \r\n "
                    + "  delivery_id,  \r\n "
                    + "  [date], \r\n "
                    + "  order_id, \r\n "
                    + "  quantity, \r\n "
                    + "  delivery_doc \r\n "
                    + "FROM OrdersDelivery  \r\n "
                    + " WHERE order_id = " + orderID;

                result = mDataBridge.ExecuteQuery(query);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }

        public DataTable GetOrdersDeliveryListShortDetailed(int clientID)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

            try
            {
                string sql = " WITH MainTBL as (Select order_id from ClientOrders Where client_ID = " + clientID + ") \r\n "
                        + "   SELECT \r\n "
                        + "     MainTBL.order_id, \r\n "
                        + "     CO.nr as \"Nr\",  \r\n "
                        + "     cast(CO.lungime as varchar) + ' x ' + cast(CO.latime as varchar) as Dimensiuni,   \r\n "
                        + "     co.bucati as \"Total Comandat\" ,\r\n "
                        + "     SUM(OD.quantity) as \"Total livrat\",\r\n "
                        + "     co.bucati - coalesce(SUM(OD.quantity),0) as \"Diferenta\",\r\n "
                        + "     CO.client_id, \r\n "
                        + "     Cl.FirstName + CASE WHEN Cl.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN ' ' + Cl.LastName ELSE '' END  as client_description \r\n "
                        + " FROM MainTBL  \r\n "
                        + " LEFT JOIN OrdersDelivery as OD ON OD.order_id = MainTBL.order_id \r\n "   
                        + " LEFT JOIN ClientOrders as CO ON CO.order_id = MainTBL.order_id  \r\n "
                        + " LEFT JOIN Client as CL ON CO.client_id = Cl.Clientid  \r\n "
                        + " GROUP BY MainTBL.order_id, CO.nr, CO.lungime, CO.latime, Cl.FirstName, Cl.LastName, Cl.gender, co.bucati, CO.client_id";                

                result = mDataBridge.ExecuteQuery(sql);
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }


        //public DataTable GetOrdersDeliveryListDetailed(int clientID)
        //{
        //    DataTable result = new DataTable();
        //    mLastError = string.Empty;

        //    try
        //    {
        //        string query = "SELECT delivery_id, date FROM OrdersDelivery WHERE order_id in (Select order_id from ClientOrders Where client_ID = " + clientID + ")";
        //        DataTable dates = mDataBridge.ExecuteQuery(query);
        //        mLastError = mDataBridge.LastError;

        //        string sql = string.Empty;

        //        if (dates != null && dates.Rows.Count > 0)
        //        {
        //            sql = " WITH MainTBL as (Select order_id from ClientOrders Where client_ID = " + clientID + ") \r\n "
        //                 + "   SELECT MainTBL.order_id, \r\n "
        //                 + "     CO.nr,  \r\n "
        //                 + "     (SELECT NAME From Classifiers WHERE Code = CO.articol) as articol_name ,  \r\n "
        //                 + "     (SELECT NAME From Classifiers WHERE Code = CO.desen) as desen_name ,  \r\n "
        //                 + "     (SELECT NAME From Classifiers WHERE Code = CO.tip) as tip_name ,  \r\n "
        //                 + "     (SELECT NAME From Classifiers WHERE Code = CO.colorit) as colorit_name ,  \r\n "
        //                 + "     cast(CO.lungime as varchar) + ' x ' + cast(CO.latime as varchar) as Dimensiuni,   \r\n ";

        //                for (int i = 0; i < dates.Rows.Count; i++)
        //                {
        //                    sql += "   OD" + i + ".date, \r\n ";
        //                }

        //                sql += "     CO.client_id, \r\n "
        //                    + "     Cl.FirstName + CASE WHEN Cl.gender = " + (int)Constants.Classifiers.ClientType_PersoanaFizica + " THEN ' ' + Cl.LastName ELSE '' END  as client_description \r\n "
        //                    + " FROM MainTBL  \r\n ";

        //            for (int i = 0; i < dates.Rows.Count; i++)
        //            {
        //                sql += " LEFT JOIN OrdersDelivery as OD" + i + " ON OD" + i + ".order_id = MainTBL.order_id \r\n ";
        //            }

        //            sql += "   LEFT JOIN ClientOrders as CO ON CO.order_id = MainTBL.order_id  \r\n "
        //                 + "   LEFT JOIN Client as CL ON CO.client_id = Cl.Clientid  \r\n ";
        //        }

        //        result = mDataBridge.ExecuteQuery(sql);
        //        mLastError = mDataBridge.LastError;
        //    }
        //    catch (Exception exception)
        //    {
        //        mLastError += "Error using DataBridge. " + exception.Message;
        //    }

        //    return result;
        //}

        public bool AddOrderDelivery(DateTime date, int orderID, int quantity, string deliveriry_doc_descr)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = "INSERT INTO  OrdersDelivery([date],  order_id,  quantity,  delivery_doc) \r\n "
                            + " VALUES (@date,  @order_id,  @quantity,  @delivery_doc); ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@date", date);
                parameters.Add("@order_id", orderID);
                parameters.Add("@quantity", quantity);
                parameters.Add("@delivery_doc", deliveriry_doc_descr);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }
        
        public bool UpdateOrderDelivery(int deliveryID, DateTime date, int orderID, int quantity, string deliveriry_doc_descr)
        {
            DateTime EmptyDate = DateTime.MinValue;

            bool result = false;
            try
            {
                string nonQuery = @"UPDATE 
                              dbo.OrdersDelivery  
                            SET 
                              [date] = @date,
                              order_id = @order_id,
                              quantity = @quantity,
                              delivery_doc = @delivery_doc 
                            WHERE delivery_id = @delivery_id ; ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@delivery_id", deliveryID);
                parameters.Add("@date", date);
                parameters.Add("@order_id", orderID);
                parameters.Add("@quantity", quantity);
                parameters.Add("@delivery_doc", deliveriry_doc_descr);

                result = mDataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = mDataBridge.LastError;
            }
            catch (Exception exception)
            {
                mLastError += "Error using DataBridge. " + exception.Message;
            }

            return result;
        }


        #endregion Customers Delivery Orders
    }

    namespace Domains
    {
        public class CustomersPersonalData
        {
            public static readonly string Name = "Customers Personal Data";
            public static readonly string Description = "Allow View/Edit Customers Personal Data";

            public static void Register()
            {
                Security.Registrar.RegisterDomain(Client.Module.ID, Name, Description);
            }
        }

        public class CustomersOrders
        {
            public static readonly string Name = "Customers Orders";
            public static readonly string Description = "Allow View/Edit Customers Orders";

            public static void Register()
            {
                Security.Registrar.RegisterDomain(Client.Module.ID, Name, Description);
            }
        }

    }

}
