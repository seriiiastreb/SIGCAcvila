<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SystemSeqAdmin.aspx.cs" Inherits="SystemSeqAdmin" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">   
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

            <script language="javascript" type="text/javascript">
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
                            "delete": { name: "Delete", icon: "delete", className: 'resetMarginLeft' },
                            "properties": { name: "Group properties", icon: "properties", className: 'resetMarginLeft' }
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
        </asp:Panel>

        <asp:HyperLink ID="userHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

        <ajax:ModalPopupExtender ID="usersPopupExtender" runat="server"     
            TargetControlID="userHyperLink"
            PopupControlID = "usersPanel" 
            PopupDragHandleControlID="usersHeader"
            CancelControlID="users_CancelButton"
            DropShadow="true" >
        </ajax:ModalPopupExtender>   

        <asp:Panel runat="server" ID="usersPanel" CssClass="grid_5 box" style=" display:none; width: auto; border:1px solid #000;">
            <h2 style="cursor:move;" runat="server" id="usersHeader"> New User  <asp:Image ID="users_CancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
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
                
                <div style="text-align:right;">
                    <asp:Button ID="users_SaveButton" runat="server" Text="Save" Width="100px"  ValidationGroup="users" onclick="users_SaveButton_Click"  />  
                </div>
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
            <h2 style="cursor:move;" runat="server" id="resetPassLegend">Reset Password <asp:Image ID="resetPassCancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
            <fieldset>			        			
                <p>
                    <asp:HiddenField ID="resetPasswordSelectedClientID" runat="server" />
				    <label>Password: </label>
                    <asp:TextBox ID="resetPassTextBox" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="resetPassRequereValiator" runat="server"  ValidationGroup="resetPWD"  EnableClientScript="true" Display="None" ControlToValidate="resetPassTextBox" ErrorMessage="This field is mandatory."> </asp:RequiredFieldValidator>
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
                        ValidationGroup="resetPWD" 
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
                <div style="text-align:right;">
                    <asp:Button ID="resetPassOkButton" runat="server" Text="Save" ValidationGroup="resetPWD" Width="100px" onclick="resetPassOkButton_Click"  />
                </div>
		    </fieldset>    
        </asp:Panel>            
              
        <asp:HyperLink ID="usersGroupProprietesHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

        <ajax:ModalPopupExtender ID="usersGroupProprietesExtender" runat="server"     
            TargetControlID="usersGroupProprietesHyperLink"
            PopupControlID = "usersGroupProprietesPanel" 
            PopupDragHandleControlID="usersGroupProprietesLegend"
            CancelControlID="usersProprietesCancelButton"
            DropShadow="true" >
        </ajax:ModalPopupExtender>   

        <asp:Panel runat="server" ID="usersGroupProprietesPanel" CssClass="grid_5 box" style="display:none; width: auto; border:1px solid #000;">
            <h2 style="cursor:move;" runat="server" id="usersGroupProprietesLegend">Users group Proprietes <asp:Image ID="usersProprietesCancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
            <fieldset>		
                <asp:HiddenField ID="usersPropr_SelecteduserIDHiddenField" runat="server" />
                <asp:UpdatePanel runat="server" ID="updatePanel">
                    <ContentTemplate>
                        <div style=" overflow:auto; width:100%; height:100%;">
                            <asp:GridView ID="usersGroupsGridView" runat="server"
                                AutoGenerateColumns="false"
                                AlternatingRowStyle-CssClass="odd"
                                OnRowCreated="usersGrid_RowCreated"
                                onrowdeleting="usersGroupsGridView_RowDeleting" 
                                AllowPaging="false"  
                                SelectedRowStyle-CssClass = "selectedRow">
                                <Columns>
                                    <asp:BoundField DataField="role_ID" HeaderText="Group Name" />             
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="deleteButton" OnClientClick="return confirm('Sure you want to delete?');" CommandName="Delete" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Delete" ImageUrl="../images/delete.png"  runat="server"  AlternateText="Delete" CausesValidation="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>                
                                </Columns>
                            </asp:GridView>
                        </div>

                        <p>
                            <label>Aviable Groups:</label>
                            <asp:DropDownList ID="usersProprertiesGroupsDDL" runat="server" Width="80%"></asp:DropDownList>
                            <asp:ImageButton ID="addUserGroupButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Add group" ImageUrl="../images/plus.png"  runat="server" OnClick="addUserGroupButton_Click" AlternateText="Add group" CausesValidation="false" />
                        </p>

                    </ContentTemplate>
                </asp:UpdatePanel>              
		    </fieldset>    
        </asp:Panel>                 
              
              
                
        <asp:Panel ID="groupsListPanel" class="context-menu-groups" style="min-height:300px;" runat="server" Visible="false">
            <script type="text/javascript" language="javascript">

                $(function () {
                    $.contextMenu({
                        selector: '.context-menu-groups',
                        trigger: 'none',
                        callback: function (key, options) {
                            if (key == "delete") {
                                if (confirm("Are you sure you want to delete?")) {
                                    doPost("groupsGridClik", key);
                                }
                            }
                            else {
                                doPost("groupsGridClik", key);
                            }

                        },
                        items: {
                            "add": { name: "Add", icon: "add", className: 'resetMarginLeft' },
                            "edit": { name: "Edit", icon: "edit", className: 'resetMarginLeft' },
                            "delete": { name: "Delete", icon: "delete", className: 'resetMarginLeft' }
                        }
                    });
                });


                $(function () {
                    $("[id*=<%= grupsGridView.ClientID %>] td").mousedown(function (e) {

                        var selectedRowIndex = $(this).parent().index();
                        var hiddField = document.getElementById('<%= groupsGridSelectedIndexHiddenField.ClientID %>');
                        hiddField.value = selectedRowIndex;

                        var gridID = '<%= grupsGridView.ClientID %>';
                        ResetGridSelection(gridID);

                        $(this).closest("tr").removeClass('odd');
                        $(this).closest("tr").toggleClass("selectedRow");

                        if (e.which == 3) //1: left, 2: middle, 3: right
                        {
                            $(".context-menu-groups").contextMenu({ x: e.pageX, y: e.pageY });
                        }
                    });
                });

                $(function () {
                    $("#<%= groupsListPanel.ClientID %>").mousedown(function (e) {
                        if (e.which == 3) {
                            $(".context-menu-groups").contextMenu({ x: e.pageX, y: e.pageY });
                        }
                    });
                });   

            </script>
                    
            <asp:HiddenField ID="groupsGridSelectedIndexHiddenField" runat="server" />

            <asp:GridView ID="grupsGridView" runat="server"
                AutoGenerateColumns="false"
                AlternatingRowStyle-CssClass="odd"
                OnRowCreated="grupsGridView_RowCreated"
                AllowPaging="false"  
                SelectedRowStyle-CssClass = "selectedRow">
                <Columns>
                    <asp:BoundField DataField="role_id" HeaderText="Group Name"  />                   
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <asp:HyperLink ID="groupHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

        <ajax:ModalPopupExtender ID="groupModalPopupExtender" runat="server"     
            TargetControlID="groupHyperLink"
            PopupControlID = "groupsPanel" 
            PopupDragHandleControlID="groupsLegend"
            CancelControlID="groupsCancelButton"
            DropShadow="true" >
        </ajax:ModalPopupExtender>   

        <asp:Panel runat="server" ID="groupsPanel" CssClass="grid_5 box" style=" display: none; width: auto; border:1px solid #000;">
            <h2 style="cursor:move;" runat="server" id="groupsLegend">Group <asp:Image ID="groupsCancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
            <fieldset>			        			
                <p>
                    <asp:HiddenField ID="groupsActionHiddenField" runat="server" />
                    <asp:HiddenField ID="selectedGroupIDHiddenField" runat="server" />
				    <label>Group Name: </label>
                    <asp:TextBox ID="groupsIDNameTextBox" runat="server"></asp:TextBox>                       
			    </p>	
                <div style="text-align:right;">
                    <asp:Button ID="groupSaveButton" runat="server" Text="Save" Width="100px" onclick="groupSaveButton_Click"  CausesValidation="false"/>
                </div>
		    </fieldset>    
        </asp:Panel>


        <asp:Panel ID="domainsListPanel" runat="server" class="context-menu-domains" Visible="false" style="min-height:300px;">
            
            <script language="javascript" type="text/javascript">

                $(function () {
                    $.contextMenu({
                        selector: '.context-menu-domains',
                        trigger: 'none',
                        callback: function (key, options) {
                            if (key == "delete") {
                                if (confirm("Are you sure you want to delete?")) {
                                    doPost("domainsGridClik", key);
                                }
                            }
                            else {
                                doPost("domainsGridClik", key);
                            }

                        },
                        items: {
                            "add": { name: "Add", icon: "add", className: 'resetMarginLeft' },
                            "edit": { name: "Edit", icon: "edit", className: 'resetMarginLeft' },
                            "delete": { name: "Delete", icon: "delete", className: 'resetMarginLeft' }
                        }
                    });
                });


                $(function () {
                    $("[id*=<%= doaminsGridView.ClientID %>] td").mousedown(function (e) {

                        var selectedRowIndex = $(this).parent().index();
                        var hiddField = document.getElementById('<%= domainsGridSelectedIndexHiddenField.ClientID %>');
                        hiddField.value = selectedRowIndex;

                        var gridID = '<%= doaminsGridView.ClientID %>';
                        ResetGridSelection(gridID);

                        $(this).closest("tr").removeClass('odd');
                        $(this).closest("tr").toggleClass("selectedRow");

                        if (e.which == 3) //1: left, 2: middle, 3: right
                        {
                            $(".context-menu-domains").contextMenu({ x: e.pageX, y: e.pageY });
                        }
                    });
                });

                $(function () {
                    $("#<%= domainsListPanel.ClientID %>").mousedown(function (e) {
                        if (e.which == 3) {
                            $(".context-menu-domains").contextMenu({ x: e.pageX, y: e.pageY });
                        }
                    });
                });        
        
            </script>

            <asp:HiddenField ID="domainsGridSelectedIndexHiddenField" runat="server" />

            <asp:GridView ID="doaminsGridView" runat="server"
                AutoGenerateColumns="false"
                AlternatingRowStyle-CssClass="odd"
                OnRowCreated="doaminsGridView_RowCreated"
                AllowPaging="false"  
                SelectedRowStyle-CssClass = "selectedRow">
                <Columns>
                    <asp:BoundField DataField="role_id" HeaderText="Group" />
                    <asp:BoundField DataField="module_id" HeaderText="Module ID" />
                    <asp:BoundField DataField="domain_id" HeaderText="Domain" />
                    <asp:BoundField DataField="permissions" HeaderText="permission" HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" />
                    <asp:BoundField DataField="permissions_name" HeaderText="Permission" />
                </Columns>
            </asp:GridView>           
            
        </asp:Panel>

        <asp:HyperLink ID="domainsHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

            <ajax:ModalPopupExtender ID="domainsModalPopupExtender" runat="server"     
                TargetControlID="domainsHyperLink"
                PopupControlID = "domainsPanel" 
                PopupDragHandleControlID="domainsLegend"
                CancelControlID="domainsCancelButton"
                DropShadow="true" >
            </ajax:ModalPopupExtender>   

            <asp:Panel runat="server" ID="domainsPanel" CssClass="grid_5 box" style="display: none; width: auto; border:1px solid #000;">
                <h2 style="cursor:move;" runat="server" id="domainsLegend">
                    Domains Permissions
                    <asp:ImageButton ID="refreshDomainsButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Refresh domains" ImageUrl="../images/refresh.png"  runat="server" OnClick="refreshDomainsButton_Click" AlternateText="Refresh domains" CausesValidation="false" />
                    <asp:Image ID="domainsCancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" />
                </h2>
                <fieldset>			        
			        <p>
				        <label>Module ID: </label>
                        <asp:DropDownList ID="moduleID_DDL" runat="server" AutoPostBack="true" OnSelectedIndexChanged="moduleID_DDL_SelectedIndexChanged" ></asp:DropDownList>                       
			        </p>

	                <p>
				        <label>Domain ID: </label>
                        <asp:DropDownList ID="domainID_DDL" runat="server"></asp:DropDownList>                       
			        </p>
                    <p>
				        <label>Group: </label>
                        <asp:DropDownList ID="roleID_DDL" runat="server"></asp:DropDownList>                       
			        </p>
	                <p>
				        <label>Permission: </label>
                        <asp:DropDownList ID="permissionDDL" runat="server"></asp:DropDownList>                       
			        </p>
                    <div style="text-align:right;">
                        <asp:Button ID="domainsSaveButton" runat="server" Text="Save" Width="100px"  CausesValidation="false" onclick="domainsSaveButton_Click"  />
                    </div>
		        </fieldset>    
            </asp:Panel>
     </div>

</asp:Content>

