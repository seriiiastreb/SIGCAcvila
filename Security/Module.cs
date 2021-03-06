﻿using System;
using System.Collections;
using System.Data;
using System.Collections.Generic;
using DAL;

namespace Security
{
    public class Module
    {
        public const string ID = "Module Security";
        public const string Description = "Creating And Processing Security Functions (Users and Groups)";
        public static readonly string DBConnectionsStringKey = "mainDBConnectionString";
        public static DataBridge DataBridge = new DataBridge(ConfigManager.GetDbConnectionString(Module.DBConnectionsStringKey), ConfigManager.GetProviderName(Module.DBConnectionsStringKey));

        private string Plus = string.Empty;

        string mLastError = string.Empty;
        public string LastError
        {
            get { return mLastError; }
        }

        public static void Register()
        {
            Registrar.RegisterModule(ID, Description);
            Domains.SecurityAdministration.Register();
        }

        public Module()
        {
            Plus = Module.DataBridge.ConcatSimbol + " ' ' " + Module.DataBridge.ConcatSimbol;
        }

        public DataTable GetGroupsList()
        {
            DataTable modules = new DataTable();

            try
            {
                string query = "SELECT role_id FROM st_roles order by role_id ";
                modules = Module.DataBridge.ExecuteQuery(query);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return modules;
        }

        public bool AddGroup(string group_id)
        {
            bool result = false;

            try
            {
                string query = "INSERT INTO st_roles (role_id) VALUES (@group_id) ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@group_id", group_id);

                result = Module.DataBridge.ExecuteNonQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool UpdateGroup(string newGroup_id, string oldGroupID)
        {
            bool result = false;

            try
            {
                string query = "UPDATE st_roles SET role_id = @newGroupID WHERE role_id = @oldGroupID ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@oldGroupID", oldGroupID);
                parameters.Add("@newGroupID", newGroup_id);

                result = Module.DataBridge.ExecuteNonQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool DeleteGroup(string group_id)
        {
            bool result = false;

            try
            {
                string query = "DELETE FROM st_roles WHERE role_id = @group_id ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@group_id", group_id);

                result = Module.DataBridge.ExecuteNonQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public DataTable GetModulesList()
        {
            DataTable modules = new DataTable();

            try
            {
                string query = "SELECT module_id, description FROM st_modules order by description ";
                modules = Module.DataBridge.ExecuteQuery(query);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return modules;
        }

        public string GetModuleDescriptionById(string moduleId)
        {
            string description = string.Empty;

            try
            {
                string query = "SELECT description FROM st_modules WHERE module_id = @moduleId  ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@moduleId", moduleId);


                DataTable modules = Module.DataBridge.ExecuteQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;

                if (modules != null && modules.Rows.Count == 1)
                {
                    description = modules.Rows[0]["description"].ToString();
                }
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return description;
        }

        public DataTable GetDomainsListInModule(string moduleID)
        {
            DataTable modules = new DataTable();

            try
            {
                string query = "SELECT module_id, domain_id, description FROM st_domains WHERE module_id = @moduleID ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@moduleID", moduleID);

                modules = Module.DataBridge.ExecuteQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return modules;
        }

        public DataTable GetPermissionsForGroup(string groupID)
        {
            DataTable permissions = new DataTable();

            try
            {
                string query = "SELECT "
                                + "    module_id "
                                + "   , role_id "
                                + "   , domain_id "
                                + "   , permissions "
                                //+ "   , module_id " + Module.DataBridge.ConcatSimbol + " '~' " + Module.DataBridge.ConcatSimbol + " role_id " + Module.DataBridge.ConcatSimbol + " '~' " + Module.DataBridge.ConcatSimbol + " domain_id " + Module.DataBridge.ConcatSimbol + " '~' " + Module.DataBridge.ConcatSimbol + " CAST(permissions as varchar)  as \"key\" "
                                //+ "   , module_id " + Module.DataBridge.ConcatSimbol + " '~' " + Module.DataBridge.ConcatSimbol + " role_id " + Module.DataBridge.ConcatSimbol + " '~' " + Module.DataBridge.ConcatSimbol + " domain_id  as \"display_key\" "
                                + " FROM  "
                                + "   st_roles_permissions "
                                + " WHERE role_id = @groupID ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@groupID", groupID);

                permissions = Module.DataBridge.ExecuteQuery(query, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return permissions;
        }

        public DataTable GetPermissionsForGroup()
        {
            DataTable permissions = new DataTable();

            try
            {
                string query = "SELECT \r\n "
                                + "    module_id \r\n"
                                + "   , role_id \r\n"
                                + "   , domain_id \r\n"
                                + "   , permissions \r\n"
                                + "   , (Select Name from Classifiers WHERE Code = permissions) as permissions_name \r\n"
                                + " FROM  \r\n"
                                + "   st_roles_permissions \r\n";


                permissions = Module.DataBridge.ExecuteQuery(query);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return permissions;
        }
        
        public bool UpdatePermissions(string moduleID, string roleID, string domainID, int permission)
        {
            bool result = false;

            try
            {
                string selectString = "SELECT * FROM st_roles_permissions WHERE module_id = @moduleID AND role_id = @roleID AND domain_id = @domainID ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@moduleID", moduleID);
                parameters.Add("@roleID", roleID);
                parameters.Add("@domainID", domainID);
                parameters.Add("@permission", permission);

                DataTable existPermisssionDT = Module.DataBridge.ExecuteQuery(selectString, parameters);
                mLastError = Module.DataBridge.LastError;

                if (existPermisssionDT != null && existPermisssionDT.Rows.Count == 1)
                {
                    string updatestrig = "UPDATE st_roles_permissions SET "
                                + " permissions = @permission "
                                + " WHERE "
                                + " module_id = @moduleID "
                                + " AND role_id = @roleID "
                                + " AND domain_id = @domainID ";

                    result = Module.DataBridge.ExecuteNonQuery(updatestrig, parameters);
                    mLastError = Module.DataBridge.LastError;
                }
                else
                {
                    string insertString = "INSERT INTO st_roles_permissions (module_id, role_id , domain_id , permissions) "
                                + "  VALUES ( @moduleID, @roleID, @domainID, @permission )  ";

                    result = Module.DataBridge.ExecuteNonQuery(insertString, parameters);
                    mLastError = Module.DataBridge.LastError;
                }
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool DeletePermissions(string moduleID, string roleID, string domainID)
        {
            bool result = false;

            try
            {
                string updatestrig = "DELETE FROM st_roles_permissions  "
                            + " WHERE "
                            + " module_id = @moduleID "
                            + " AND role_id = @roleID "
                            + " AND domain_id = @domainID ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@moduleID", moduleID);
                parameters.Add("@roleID", roleID);
                parameters.Add("@domainID", domainID);

                result = Module.DataBridge.ExecuteNonQuery(updatestrig, parameters);
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }
        
        #region Users Region

        public DataTable GetUserInfoByID(int userID)
        {
            DataTable usersList = new DataTable();

            try
            {
                string commandText = "SELECT  *  "
                                    + " , (SELECT name FROM Classifiers WHERE Code = passwordstatus) as passwordstatus_string "
                                    + " , (SELECT name FROM Classifiers WHERE Code = recordstatus) as recordstatus_string "
                                    + " , nume " + Plus + " Prenume as UserFullName"

                                    + "  FROM Users WHERE userID = " + userID;

                usersList = Module.DataBridge.ExecuteQuery(commandText); // PG compliant
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return usersList;
        }

        public DataTable GetUsersList()
        {
            DataTable usersList = new DataTable();

            try
            {
                string commandText = "SELECT  *  "
                                    + " , (SELECT name FROM Classifiers WHERE Code = passwordstatus) as passwordstatus_string "
                                    + " , (SELECT name FROM Classifiers WHERE Code = recordstatus) as recordstatus_string "
                                    + " , nume " + Plus + " Prenume as UserFullName"

                                    + "  FROM Users  order BY Nume, Prenume";

                usersList = Module.DataBridge.ExecuteQuery(commandText); // PG compliant
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return usersList;
        }

        public DataTable GetUserGroupsList(int userID)
        {
            DataTable usersList = new DataTable();

            try
            {
                string commandText = "SELECT  *  FROM st_users_roles WHERE user_id = " + userID;

                usersList = Module.DataBridge.ExecuteQuery(commandText); // PG compliant
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return usersList;
        }

        public bool AddGroupForUser(int userID, string role_id)
        {
            bool result = false;

            try
            {
                string nonQuery = @"INSERT INTO st_users_roles (user_id, role_id) Values (" + userID + ", @roleID); ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@roleID", role_id);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = Module.DataBridge.LastError;                
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool DeleteGroupForUser(int userID, string role_id)
        {
            bool result = false;

            try
            {
                string nonQuery = @"DELETE FROM st_users_roles WHERE user_id = " + userID + " AND role_id = @roleID; ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@roleID", role_id);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }


        public bool UpdateUserPasswordByLoginAndEmail(string login, string email, string newPassword)
        {
            bool result = false;

            try
            {                
                string encryptPassword = Crypt.Module.ComputeHash(newPassword);

                string nonQuery = @"Update Users Set password = @encryptPassword  WHERE login = @login and email = @email ";

                Hashtable parameters = new Hashtable();
                parameters.Add("@encryptPassword", encryptPassword);
                parameters.Add("@login", login);
                parameters.Add("@email", email);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = Module.DataBridge.LastError;                
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }
        
        public bool DeleteUser(int userID)
        {
            bool result = false;

            try
            {                
                string nonQuery = @"Delete From Users WHERE userID = " + userID;

                result = Module.DataBridge.ExecuteNonQuery(nonQuery); // PG compliant
                mLastError = Module.DataBridge.LastError;               
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool ResetUserPassword(int userID, string newPassword)
        {
            bool result = false;

            try
            {
                string encryptPassword = Crypt.Module.ComputeHash(newPassword);

                string nonQuery = "UPDATE Users SET "
                        + " password = @encryptPassword  "
                        + " WHERE userID = " + userID;

                Hashtable parameters = new Hashtable();
                parameters.Add("@encryptPassword", encryptPassword);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError += Module.DataBridge.LastError;
            }
            catch(Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }

        public bool NewUser(string Nume, string Prenume, string login, string email, int recordstatusID)
        {
            bool result = false;

            try
            {             
                string nonQuery = @"INSERT INTO Users (Nume, Prenume, login,    email,  recordstatus, password, sysadmin)"
                                        + " VALUES ( @Nume, @Prenume, @login,  @email, @recordstatusID, @password, @sysadmin)";

                Hashtable parameters = new Hashtable();
                parameters.Add("@Nume", Nume);
                parameters.Add("@Prenume", Prenume);
                parameters.Add("@login", login);
                parameters.Add("@email", email);
                parameters.Add("@recordstatusID", recordstatusID);
                parameters.Add("@password", Crypt.Module.CreateRandomPassword(8));
                parameters.Add("@sysadmin", false);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError = Module.DataBridge.LastError;
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }
        
        public bool UpdateUser(int userID, string Nume, string Prenume, string login, string email, int recordstatusID)
        {
            bool result = false;

            try
            {
                string nonQuery = @"Update Users Set "
                        + " Nume = @Nume  "
                        + " , Prenume = @Prenume  "
                        + " , login = @login  "
                        + " , email = @email  "
                        + " , recordstatus = @recordstatusID "
                        + " WHERE userID = " + userID;

                Hashtable parameters = new Hashtable();
                parameters.Add("@Nume", Nume);
                parameters.Add("@Prenume", Prenume);
                parameters.Add("@login", login);
                parameters.Add("@email", email);
                parameters.Add("@recordstatusID", recordstatusID);

                result = Module.DataBridge.ExecuteNonQuery(nonQuery, parameters); // PG compliant
                mLastError += Module.DataBridge.LastError;            
            }
            catch (Exception ex)
            {
                mLastError += ex.Message;
            }

            return result;
        }
        
        #endregion Users Region        
    }

    namespace Domains
    {
        /// <summary>
        /// Default domain. Calculations.
        /// </summary>
        public class SecurityAdministration
        {
            public static readonly string Name = "Security Administration";
            public static readonly string Description = "Security Administration";

            public static void Register()
            {
                Registrar.RegisterDomain(Security.Module.ID, Name, Description);
            }
        }
    }
}
