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
              
        public DataTable GetClientList(int category, List<int> genderList)
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

        #endregion Customers Orders
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
