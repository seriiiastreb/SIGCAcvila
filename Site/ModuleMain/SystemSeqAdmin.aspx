<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SystemSeqAdmin.aspx.cs" Inherits="SystemSeqAdmin" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register TagPrefix="ib" TagName="InfoWindow" Src="~/Controls/InfoWindow.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">  

    <asp:Button ID="groupsDomainsButton" runat="server" Width="200px" Text="Groups And Domains" onclick="groupsDomainsButton_Click" CausesValidation="false" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="usersListButton" runat="server"  Width="200px" Text="Users List" onclick="usersListButton_Click" CausesValidation="false"/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
    <asp:UpdatePanel ID="groupPermissionsConfigPanel" runat="server" Visible="false">
        <ContentTemplate>
            <div class="module">
                <div class="moduleHeader">Lista Grupelor si Permisionilor</div>  
                <div class="module_content">
                    <div style=" float:left;">
                        <asp:Button ID="regreshButton" runat="server" Text="Refresh" Width="100px" onclick="regreshButton_Click" />
                        &nbsp;&nbsp;
                        <asp:Button ID="newGroupButton" runat="server" Text="New Group" Width="100px" onclick="newGroupButton_Click"  />
                        &nbsp;&nbsp;
                        <asp:Button ID="deleteGroupButton" runat="server" Text="Delete" Width="100px" onclick="deleteGroupButton_Click" />
                    </div>
                       
                    <div runat="server" id="newGroupPanel" visible="false" style="float:left;">
                        &nbsp;&nbsp;&nbsp;             
                        <asp:TextBox ID="newGroupTextBox" runat="server"  Width="250px"></asp:TextBox> 
                        &nbsp;&nbsp;
                        <asp:Button ID="newGroupSaveButton" runat="server" Text="Save" Width="100px" onclick="newGroupSaveButton_Click" />
                        &nbsp;&nbsp;
                        <asp:Button ID="newGroupCancelButton" runat="server" Text="Cancel" Width="100px" onclick="newGroupCancelButton_Click"  />
                    </div>
                    <div class="clear"></div>
                    <asp:ListBox ID="groupsListBox" runat="server" Width="100%" Height="120px" onselectedindexchanged="groupsListBox_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                    <br /><br />

                    <div style="height:200px;">
                        <div style="float:left; width:45%; min-width:150px;"> 
                            <asp:Label ID="Label1" runat="server" Text="Efective Permissions:"></asp:Label>                                                 
                            <asp:ListBox ID="efectivePermissionsGroupListBox" runat="server" Width="100%" Height="170px" onselectedindexchanged="efectivePermissionsGroupListBox_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="efectivePermissions_Read_RadioButton" Text="Read" GroupName="efectivePermissions" runat="server" AutoPostBack="true" oncheckedchanged="efectivePermissions_Read_RadioButton_CheckedChanged"  />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="efectivePermissions_Write_RadioButton" Text="Write" GroupName="efectivePermissions" runat="server" AutoPostBack="true" oncheckedchanged="efectivePermissions_Write_RadioButton_CheckedChanged"  />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="efectivePermissions_Denied_RadioButton" Text="Denied" GroupName="efectivePermissions" runat="server" AutoPostBack="true" oncheckedchanged="efectivePermissions_Denied_RadioButton_CheckedChanged"  />
                        </div>
                        <div style="float:left; width:9%; min-width:40px; height:200px;">
                                <div class="centerBox" style="width:20px; padding-top:30px;">
                                    <asp:ImageButton ID="moveToRightButton" runat="server" Width="20px" Height="20px" ImageUrl="~/App_Images/blackwhite_right.png" onclick="moveToRightButton_Click" />
                                    <br />                                                     
                                    <br />
                                    <asp:ImageButton ID="moveToLeftButton" runat="server" Width="20px" Height="20px" ImageUrl="~/App_Images/blackwhite_left.png" onclick="moveToLeftButton_Click" />
                                    <br />                                                     
                                    <br />
                                    <asp:ImageButton ID="moveAllToRightButton" runat="server" Width="20px" Height="20px" ImageUrl="~/App_Images/blackwhite_all_right.png" onclick="moveAllToRightButton_Click" />                                                     
                                    <br />                                                     
                                    <br />
                                    <asp:ImageButton ID="moveAllToLeftButton" runat="server" Width="20px" Height="20px" ImageUrl="~/App_Images/blackwhite_all_left.png" onclick="moveAllToLeftButton_Click" />
                                </div>
                        </div>
                        <div style="float:right; width:45%; min-width:150px;">
                            <asp:Label ID="Label2" runat="server" Text="Aviable modules:"></asp:Label> 
                            <asp:DropDownList ID="aviableModulesDDL" runat="server" Width="220px" AutoPostBack="True" onselectedindexchanged="aviableModulesDDL_SelectedIndexChanged"></asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Button ID="registerModulesButton" runat="server" Text="Refresh Modules List" Width="140px" onclick="registerModulesButton_Click" />
                            <br />
                            <asp:ListBox ID="aviableDomaninsListBox" runat="server" Width="100%" Height="170px"></asp:ListBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                   <%-- <div class="centerBox" style="width:225px;">
                        <asp:Button ID="okGroupSecurityButton" runat="server" Text="Ok" Width="100px" onclick="okGroupSecurityButton_Click" />
                        &nbsp;&nbsp;
                        <asp:Button ID="cancelGroupSecurityButton" runat="server" Text="Cancel" Width="100px" onclick="cancelGroupSecurityButton_Click" />
                    </div>--%>

                </div>
            </div>      
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <asp:UpdatePanel ID="usersAdminPanel" runat="server" Visible="false">
        <ContentTemplate>

           <div class="module">
                <div class="moduleHeader">User administration form</div>
                <div class="module_content">         
                    <asp:Button ID="refreshUsersGridButton" runat="server" Text="Refresh Users List" Width="170px" onclick="refreshUsersGridButton_Click" CausesValidation="false" />
                     &nbsp;&nbsp; &nbsp;&nbsp;
                    <asp:Button ID="newUsersButton" runat="server" Text="New User" Width="170px" onclick="newUsersButton_Click" CausesValidation="false"/>

                    <br />
                    <div class="leftColumn">                
                        <asp:GridView ID="usersGridView" runat="server" 
                            AutoGenerateColumns="False"
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            AllowPaging="True"        
                            PageSize="10" 
                            onpageindexchanging="usersGridView_PageIndexChanging" 
                            onrowdeleting="usersGridView_RowDeleting" 
                            onrowdatabound="usersGridView_RowDataBound" 
                            onselectedindexchanged="usersGridView_SelectedIndexChanged">
            
                            <Columns>
                                <asp:BoundField DataField="UserID"              HeaderText="User ID"          HtmlEncode="False"  HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass = "HiddenColumn"  />  
                                <asp:BoundField DataField="Nume"                HeaderText="Nume"             HtmlEncode="False" /> 
                                <asp:BoundField DataField="Prenume"             HeaderText="Prenume"          HtmlEncode="False" />  
                                <asp:BoundField DataField="login"               HeaderText="Login"            HtmlEncode="False" />  
                                <asp:BoundField DataField="email"               HeaderText="Email"            HtmlEncode="False" />  
                                <asp:BoundField DataField="passwordstatus"      HeaderText="Password Status ID"     HtmlEncode="False" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass = "HiddenColumn"  />  
                                <asp:BoundField DataField="passwordstatus_string"     HeaderText="Password Status"        HtmlEncode="False" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass = "HiddenColumn" />  
                                <asp:BoundField DataField="recordstatus"      HeaderText="Record Status ID"     HtmlEncode="False" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass = "HiddenColumn"  />  
                                <asp:BoundField DataField="recordstatus_string"     HeaderText="Record Status"        HtmlEncode="False" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass = "HiddenColumn"/>  

                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Sunteti sigur ca vreti sa stergeti?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>  
                            </Columns>           
                        </asp:GridView>
                    </div>
                    <div class="rightColumn">
                        <asp:UpdatePanel ID="userDetailsPanel" runat="server" Visible="False">
                            <ContentTemplate>
                                <div class="leftColumn">
                                    <div class="module">
                                        <div class="moduleHeader">User Details</div>
                                        <div class="module_content">
                                            <p>
					                            <label>Nume: </label>
                                                <asp:HiddenField ID="userDetailsActionHiddenField" runat="server" />
                                                <asp:HiddenField ID="userDetailsUserIDHiddenField" runat="server" />
					                            <asp:TextBox ID="userDetails_Nume_TextBox" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="userDetails_Nume_TextBox" ErrorMessage="Acest cimp este obligatoriu"> </asp:RequiredFieldValidator>
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="PNReqE"
                                                    TargetControlID="RequiredFieldValidator" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>
				                            <p>
					                            <label>Prenume: </label>
					                            <asp:TextBox ID="userDetails_Prenume_TextBox" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" EnableClientScript="true" Display="None" ControlToValidate="userDetails_Prenume_TextBox" ErrorMessage="Acest cimp este obligatoriu"> </asp:RequiredFieldValidator>
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender1"
                                                    TargetControlID="RequiredFieldValidator2" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>
				                            <p>
					                            <label>Login: </label>
                                                <asp:TextBox ID="userDetails_Login_TextBox" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" EnableClientScript="true" Display="None" ControlToValidate="userDetails_Login_TextBox" ErrorMessage="Acest cimp este obligatoriu"> </asp:RequiredFieldValidator>
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender2"
                                                    TargetControlID="RequiredFieldValidator3" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>		
                                            <p>
					                            <label>Email: </label>
                                                <asp:TextBox ID="userDetails_Email_TextBox" runat="server" ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" EnableClientScript="true" Display="None" ControlToValidate="userDetails_Email_TextBox"  ErrorMessage="Acest cimp este obligatoriu"> </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator runat="server" ID="valEmailPattern" Display="None" ControlToValidate="userDetails_Email_TextBox" ErrorMessage="The email is not well formed." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender3"
                                                    TargetControlID="RequiredFieldValidator4" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender6"
                                                    TargetControlID="valEmailPattern" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>
                                            <p>
                                                <asp:CheckBox ID="userDetails_ResetPasswordCheckBox" runat="server"  AutoPostBack="true" Text="Reset Password" Checked="false" oncheckedchanged="userDetails_ResetPasswordCheckBox_CheckedChanged"/> 
                                            </p>

				                            <p>
					                            <label>Password: </label>
                                                <asp:TextBox ID="userDetails_Password_TextBox" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="userDetails_Password_RequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="userDetails_Password_TextBox" ErrorMessage="Acest cimp este obligatoriu"> </asp:RequiredFieldValidator>
                                                <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender4"
                                                    TargetControlID="userDetails_Password_RequiredFieldValidator" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>

				                            <p>
					                            <label>Repeat Password: </label>
                                                <asp:TextBox ID="userDetails_RepeatPassword_TextBox" runat="server" TextMode="Password"></asp:TextBox>
                                                <asp:CompareValidator id="comparePasswords" 
                                                    runat="server"
                                                    ControlToCompare="userDetails_RepeatPassword_TextBox"
                                                    ControlToValidate="userDetails_Password_TextBox"
                                                    ErrorMessage="Atentie! Parolele nu coincid"
                                                    Display="None" />
                                                 <ajax:ValidatorCalloutExtender 
                                                    runat="Server"
                                                    ID="ValidatorCalloutExtender5"
                                                    TargetControlID="comparePasswords" 
                                                    Width="250px"
                                                    PopupPosition="Right" />
				                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="rightColumn">
                                    <div class="module">
                                        <div class="moduleHeader"></div>
                                        <div class="module_content">  
	                                        <p>
					                            <label>User Groups: </label>
                                                <asp:ListBox ID="userDetails_GoupsListBox" runat="server" Height="180px" SelectionMode="Multiple"></asp:ListBox>
				                            </p>

	                                        <p>
					                            <label>Password Status: </label>
                                                <asp:DropDownList ID="userDetails_PasswordStatusDDL" runat="server" ></asp:DropDownList>
				                            </p>

	                                        <p>
					                            <label>Record Status: </label>
                                                <asp:DropDownList ID="userDetails_RecordStatusDDL" runat="server"  ></asp:DropDownList>
				                            </p>
                                        </div>				         
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <div class="centerBox" style="width:210px;">
                                    <asp:Button ID="userDetails_SaveButton" runat="server" Text="Save" Width="100px" onclick="userDetails_SaveButton_Click"  />
                                    <asp:Button ID="userDetails_CancelButton" runat="server" Text="Cancel" Width="100px" onclick="userDetails_CancelButton_Click"  CausesValidation="false" />                   
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

