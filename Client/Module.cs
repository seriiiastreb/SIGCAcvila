using System;
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
        public const string Description = "Processing data customer related";
        public static readonly string DBConnectionsStringKey = "mainDBConnectionString";
        public static DataBridge mDataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Module.DBConnectionsStringKey), ConfigManager.GetProviderName(Module.DBConnectionsStringKey));

        private string Plus = string.Empty;

        string mLastError = string.Empty;
        public string LastError
        {
            get { return mLastError; }
        }

        public Module()
        {
            Plus = Module.mDataBridge.ConcatSimbol + " ' ' " + Module.mDataBridge.ConcatSimbol;
        }

        #region Client Region

        public bool AddNewClient(ref DataObjects.Client clientObject)
        {
            DateTime EmptyDate = DateTime.MinValue;
            int newClientID = 0;

            bool result = false;
            try
            {
                if (clientObject != null)
                {


                    string nonQuery = "INSERT INTO Client (gender,FirstName,LastName,           DateOfBirth,                                               personalID,    buletinSeria,                         dataEliberarii,                                                                                 dataExpirarii,                                                  eliberatDe,  telefonFix,  telefonMobil,   viza_country, viza_raion,  viza_urbanRural,  viza_localitatea,   viza_stradaAdresa,  email,  sortGroup)  "
                                + " OUTPUT INSERTED.ClientID "
                                + " VALUES (@gender, @FirstName, @LastName, " + (clientObject.BirthDate.Equals(EmptyDate) ? "NULL" : "@DateOfBirth") + ", @personalID, , @buletinSeria, " + (clientObject.DataEliberariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataEliberarii") + ", " + (clientObject.DataExpirariiBuletin.Equals(EmptyDate) ? "NULL" : "@dataExpirarii") + ", @eliberatDe, @telefonFix, @telefonMobil, @viza_country, @viza_raion, @viza_urbanRural, @viza_localitatea, @viza_stradaAdresa, @email, @sortGroup ); ";

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
                    parameters.Add("@viza_urbanRural", clientObject.Viza_UrbanRural);
                    parameters.Add("@viza_localitatea", clientObject.Viza_Localitatea);
                    parameters.Add("@viza_stradaAdresa", clientObject.Viza_StradaAdresa);                    
                    parameters.Add("@email", clientObject.Email);
                    parameters.Add("@sortGroup", clientObject.SortGroup);

                    object insertedID = mDataBridge.ExecuteScalarQuery(nonQuery, parameters); // PG compliant
                    mLastError = mDataBridge.LastError;

                    if (insertedID != null && !insertedID.ToString().Equals(string.Empty))
                    {
                        newClientID = (int)insertedID;
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
                    + "   viza_urbanRural = @viza_urbanRural,\r\n "
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
                    parameters.Add("@viza_urbanRural", clientObject.Viza_UrbanRural);
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
              
        public DataTable GetClientList(int clinetCategory)
        {
            DataTable result = new DataTable();
            mLastError = string.Empty;

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

                            + " FROM CLIENT"
                            + (clinetCategory != 0 ? " WHERE sortGroup = " + clinetCategory : string.Empty)
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
                string query = "Select * "
                            + " , coalesce(firstName, '') " + Plus + " coalesce(lastName, '') as \"Client Full Name\" "
                            + " , (select Name From Classifiers Where Code = gender) as gender_string "
                            + " , (select Name From Classifiers Where Code = viza_country) as viza_country_string "
                            + " , (select Name From Classifiers Where Code = viza_raion) as viza_raion_string "
                            + " , coalesce(telefonMobil, '') " + Plus + " coalesce(telefonFix, '') as telefon "
                            + " , (select Name From Classifiers Where Code = SortGroup) as SortGroup_string "
                            //+ " , ( CASE WHEN (SELECT COUNT(*) FROM Loans WHERE Loans.clientID = client.ClientID) <> 0 THEN @NotAllowDelete ELSE @AllowDelete END ) as AllowDelete "

                            + " FROM Client \r\n  "                 

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
    }

    namespace Domains
    {
        /// <summary>
        /// Default domain. Calculations.
        /// </summary>
        public class ClientsInputData
        {
            public static readonly string Name = "Customers Input Data";
        }
    }

}
