<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SystemSeqAdmin.aspx.cs" Inherits="SystemSeqAdmin" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">   

    <script language="javascript">

        $(function () {
            $.contextMenu({
                selector: '.context-menu-users',
                trigger: 'none',
                callback: function (key, options) {
                    if (key == "delete") {
                        if (confirm("Are you sure you want to delete?")) {
                            doPost("usersGridClik", key);
                        }
                    }
                    else {
                        doPost("usersGridClik", key);
                    }
                   
                },
                items: {
                    "add": { name: "Add", icon: "add", className: 'resetMarginLeft' },
                    "edit": { name: "Edit", icon: "edit", className: 'resetMarginLeft' },
                    "reset": { name: "Reset PWD", icon: "reset", className: 'resetMarginLeft' },                   
                    "delete": { name: "Delete", icon: "delete", className: 'resetMarginLeft' }
                }
            });
        });


        $(function () {
            $("[id*=<%= usersGrid.ClientID %>] td").mousedown(function (e) {

                var selectedRowIndex = $(this).parent().index();
                var hiddField = document.getElementById('<%= usersGrid_SelectedIndex_HiddenValue.ClientID %>');
                hiddField.value = selectedRowIndex;

                var gridID = '<%= usersGrid.ClientID %>';
                ResetGridSelection(gridID);

                $(this).closest("tr").removeClass('odd');
                $(this).closest("tr").toggleClass("selectedRow");

                if (e.which == 3) //1: left, 2: middle, 3: right
                {
                    $(".context-menu-users").contextMenu({ x: e.pageX, y: e.pageY });
                }
            });
        });

        $(function () {
            $("#<%= usersListPanel.ClientID %>").mousedown(function (e) {
                if (e.which == 3) {
                    $(".context-menu-users").contextMenu({ x: e.pageX, y: e.pageY });
                }
            }); 
        });   





     
        
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">  

    <div class="grid_3 box">
		<h2>
			System Management
		</h2>
		<div class="block" id="list-items">
			<p>Here you can add/edit users and groups in system. And you can change permissions of them.</p>
			<h5>Users and Grousp</h5>
			<ul class="menu">
				<li>
                    <asp:LinkButton ID="usersListLinkButton" runat="server" Text="Users" CausesValidation="false" onclick="usersListLinkButton_Click"></asp:LinkButton>
				</li>
				<li>
                    <asp:LinkButton ID="groupsListLinkButton" runat="server" Text="Groups" CausesValidation="false" onclick="groupsListLinkButton_Click"></asp:LinkButton>
				</li>
				<li>
					<asp:LinkButton ID="domainsListLinkButton" runat="server" Text="Domains" CausesValidation="false" onclick="domainsListLinkButton_Click"></asp:LinkButton>
				</li>
			</ul>
        </div>
    </div>

     <div class="grid_10 box" style=" min-height:300px;">
        <h2>
		    <asp:Label ID="currentSelected"  runat="server" Text=""></asp:Label>
	    </h2>

        <asp:Panel ID="usersListPanel" class="context-menu-users" runat="server" Visible="false" style="min-height:300px;">

            <asp:HiddenField ID="usersGrid_SelectedIndex_HiddenValue" runat="server" />

            <asp:GridView ID="usersGrid" runat="server"
                AutoGenerateColumns="false"
                AlternatingRowStyle-CssClass="odd"
                OnRowCreated="usersGrid_RowCreated"
                AllowPaging="false"  
                SelectedRowStyle-CssClass = "selectedRow">
                <Columns>
                    <asp:BoundField DataField="userid" HeaderText="User ID"  HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" />
                    <asp:BoundField DataField="nume" HeaderText="First Name" />
                    <asp:BoundField DataField="prenume" HeaderText="Last Name" />
                    <asp:BoundField DataField="login" HeaderText="Login" />                   
                    <asp:BoundField DataField="recordstatus" HeaderText="recordstatus" HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" />
                    <asp:BoundField DataField="recordstatus_string" HeaderText="Record Status" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="sysadmin" HeaderText="Sys Admin" />
                </Columns>
            </asp:GridView>

            <asp:HyperLink ID="userHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

            <ajax:ModalPopupExtender ID="usersPopupExtender" runat="server"     
                TargetControlID="userHyperLink"
                PopupControlID = "usersPanel" 
                PopupDragHandleControlID="usersHeader"
                CancelControlID="users_CancelButton"
                DropShadow="true" >
            </ajax:ModalPopupExtender>   

            <asp:Panel runat="server" ID="usersPanel" CssClass="grid_5 box" style="display: none; width: auto; border:1px solid #000;">
                <h2 style="cursor:move;" runat="server" id="usersHeader">New User</h2>
                <fieldset>			        
			        <p>
                        <asp:HiddenField ID="usersActionHiddenField" runat="server" />
                        <asp:HiddenField ID="usersSelectedUserIDHiddenField" runat="server" />

				        <label>First Name: </label>
                        <asp:TextBox ID="users_Nume_TextBox" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ValidationGroup="users" EnableClientScript="true" Display="None" ControlToValidate="users_Nume_TextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                        <ajax:ValidatorCalloutExtender 
                            runat="Server"
                            ID="PNReqE"                     
                            TargetControlID="RequiredFieldValidator" 
                            Width="250px"
                            PopupPosition="Right" />
			        </p>
                    <p>
				        <label>Last Name: </label>
				        <asp:TextBox ID="users_Prenume_TextBox" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ValidationGroup="users" EnableClientScript="true" Display="None" ControlToValidate="users_Prenume_TextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                        <ajax:ValidatorCalloutExtender 
                            runat="Server"
                            ID="ValidatorCalloutExtender1"
                            TargetControlID="RequiredFieldValidator2" 
                            Width="250px"
                            PopupPosition="Right" />
			        </p>

			        <p>
				        <label>Login: </label>
				        <asp:TextBox ID="users_Login_TextBox" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"  ValidationGroup="users" EnableClientScript="true" Display="None" ControlToValidate="users_Login_TextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                        <ajax:ValidatorCalloutExtender 
                            runat="Server"
                            ID="ValidatorCalloutExtender2"
                            TargetControlID="RequiredFieldValidator3" 
                            Width="250px"
                            PopupPosition="Right" />
			        </p>

			        <p>
				        <label>Email: </label>
                        <asp:TextBox ID="users_Email_TextBox" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"  ValidationGroup="users"  EnableClientScript="true" Display="None" ControlToValidate="users_Email_TextBox"  ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="valEmailPattern" Display="None"  ValidationGroup="users" ControlToValidate="users_Email_TextBox" ErrorMessage="The email is not well formed." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
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
				        <label>Record Status: </label>
                        <asp:DropDownList ID="userDetails_RecordStatusDDL" runat="server"  ></asp:DropDownList>
			        </p>

                    <asp:Button ID="users_SaveButton" CssClass="register-button" runat="server" Text="Save" Width="100px"  ValidationGroup="users" onclick="users_SaveButton_Click"  />
                    <asp:Button ID="users_CancelButton" runat="server" Text="Cancel" Width="100px" CausesValidation="false" />                   
              
		        </fieldset>    
            </asp:Panel>


            

            <asp:HyperLink ID="resetPassHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

            <ajax:ModalPopupExtender ID="resetPassPopupExtender" runat="server"     
                TargetControlID="resetPassHyperLink"
                PopupControlID = "resetPassPanel" 
                PopupDragHandleControlID="resetPassLegend"
                CancelControlID="resetPassCancelButton"
                DropShadow="true" >
            </ajax:ModalPopupExtender>   

             <asp:Panel runat="server" ID="resetPassPanel" CssClass="grid_5 box" style=" display: none; width: auto; border:1px solid #000;">
                <h2 style="cursor:move;" runat="server" id="resetPassLegend">Reset Password</h2>
                <fieldset>			        			
                    <p>
                        <asp:HiddenField ID="resetPasswordSelectedClientID" runat="server" />
				        <label>Password: </label>
                        <asp:TextBox ID="resetPassTextBox" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="resetPassRequereValiator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="resetPassTextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                        <ajax:ValidatorCalloutExtender 
                            runat="Server"
                            ID="ValidatorCalloutExtender12"
                            TargetControlID="resetPassRequereValiator" 
                            Width="250px"
                            PopupPosition="Right" />
			        </p>

			        <p>
				        <label>Repeat Password: </label>
                        <asp:TextBox ID="resetPass_repeatTextBox" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:CompareValidator id="resetPass_CompareValidator" 
                            runat="server"
                            ControlToCompare="resetPass_repeatTextBox"
                            ControlToValidate="resetPassTextBox"
                            ErrorMessage="Attention! Passwords do not match."
                            Display="None" />

                            <ajax:ValidatorCalloutExtender 
                            runat="Server"
                            ID="ValidatorCalloutExtender13"
                            TargetControlID="resetPass_CompareValidator" 
                            Width="250px"
                            PopupPosition="Right" />
			        </p>       

                    <asp:Button ID="resetPassOkButton" CssClass="register-button" runat="server" Text="Save" Width="100px" onclick="resetPassOkButton_Click"  />
                    <asp:Button ID="resetPassCancelButton" runat="server" Text="Cancel" Width="100px" CausesValidation="false" />  
		        </fieldset>    
            </asp:Panel>





        </asp:Panel>

        <asp:Panel ID="groupsListPanel" runat="server" Visible="false">
        </asp:Panel>

        <asp:Panel ID="domainsListPanel" runat="server" Visible="false">
        </asp:Panel>
     </div>




   <%--

    <asp:HyperLink ID="editUserHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

    <ajax:ModalPopupExtender ID="editUserPopupExtender" runat="server"     
        TargetControlID="editUserHyperLink"
        PopupControlID = "editUserPanel" 
        PopupDragHandleControlID="editUserLegend"
        CancelControlID="editUserCancelButton"
        DropShadow="true" >
    </ajax:ModalPopupExtender>   

    <asp:Panel runat="server" ID="editUserPanel" CssClass="grid_5 box" style="display:none; width: auto">
        <fieldset>
			<legend style="cursor:move;" runat="server" id="editUserLegend">Edit User</legend>
			<p>
				<label>First Name: </label>
                <asp:TextBox ID="editUserNumeTextBox" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="editUserNameRequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="editUserNumeTextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                <ajax:ValidatorCalloutExtender 
                    runat="Server"
                    ID="ValidatorCalloutExtender7"                     
                    TargetControlID="editUserNameRequiredFieldValidator" 
                    Width="250px"
                    PopupPosition="Right" />
			</p>

            <p>
				<label>Last Name: </label>
				<asp:TextBox ID="editUserLastNameTextBox" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="ediuUserlastNameRequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="editUserLastNameTextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                <ajax:ValidatorCalloutExtender 
                    runat="Server"
                    ID="ValidatorCalloutExtender8"
                    TargetControlID="ediuUserlastNameRequiredFieldValidator" 
                    Width="250px"
                    PopupPosition="Right" />
			</p>

			<p>
				<label>Login: </label>
				<asp:TextBox ID="editUserLoginTextBox" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="editUserLoginRequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="editUserLoginTextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                <ajax:ValidatorCalloutExtender 
                    runat="Server"
                    ID="ValidatorCalloutExtender9"
                    TargetControlID="editUserLoginRequiredFieldValidator" 
                    Width="250px"
                    PopupPosition="Right" />
			</p>

			<p>
				<label>Email: </label>
                <asp:TextBox ID="editUserEmailTextBox" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="editUserEmailRequiredFieldValidator" runat="server" EnableClientScript="true" Display="None" ControlToValidate="editUserEmailTextBox"  ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ID="emailRegularExpressionValidator" Display="None" ControlToValidate="editUserEmailTextBox" ErrorMessage="The email is not well formed." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                <ajax:ValidatorCalloutExtender 
                    runat="Server"
                    ID="ValidatorCalloutExtender10"
                    TargetControlID="editUserEmailRequiredFieldValidator" 
                    Width="250px"
                    PopupPosition="Right" />
                <ajax:ValidatorCalloutExtender 
                    runat="Server"
                    ID="ValidatorCalloutExtender11"
                    TargetControlID="emailRegularExpressionValidator" 
                    Width="250px"
                    PopupPosition="Right" />
			</p>           

            <p>
				<label>Password Status: </label>
                <asp:DropDownList ID="editUserPWDStatusDDL" runat="server" ></asp:DropDownList>
			</p>

	        <p>
				<label>Record Status: </label>
                <asp:DropDownList ID="editUserRECStatus" runat="server"  ></asp:DropDownList>
			</p>

            <asp:Button ID="editUserOkButton" CssClass="register-button" runat="server" Text="Save" Width="100px" onclick="editUserOkButton_Click"  />
            <asp:Button ID="editUserCancelButton" runat="server" Text="Cancel" Width="100px" CausesValidation="false" />                   
              
		</fieldset>    
    </asp:Panel>


    <asp:HyperLink ID="deleteUserHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

    <ajax:ModalPopupExtender ID="deleteUserModalPopupExtender" runat="server"     
        TargetControlID="deleteUserHyperLink"
        PopupControlID = "deleteUserPanel" 
        PopupDragHandleControlID="deleteUserLegend"
        CancelControlID="deleteUserCancelButton"
        DropShadow="true" >
    </ajax:ModalPopupExtender>   

    <asp:Panel runat="server" ID="deleteUserPanel" CssClass="grid_5 box" style="display:none; width: auto">
        <fieldset>
			<legend style="cursor:move;" runat="server" id="deleteUserLegend">Delete User confirmation</legend>			
            <p>
                <h3>Sure you want to delete this user from the system? After this operation he will not have access to the system.</h3>
            </p>

            <asp:Button ID="deleteUserOkButton" CssClass="register-button" runat="server" Text="Ok" Width="100px" onclick="deleteUserOkButton_Click"  />
            <asp:Button ID="deleteUserCancelButton" runat="server" Text="Cancel" Width="100px" CausesValidation="false" />                   
              
		</fieldset>    
    </asp:Panel>
--%>
</asp:Content>

