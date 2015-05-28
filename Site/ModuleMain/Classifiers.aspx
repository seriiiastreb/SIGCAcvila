<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Classifiers.aspx.cs" Inherits="Classifiers" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">

    <script type="text/javascript" language="javascript">

        $(function () {
            $.contextMenu({
                selector: '.context-menu-classifierTypes',
                trigger: 'none',
                callback: function (key, options) {
                    if (key == "delete") {
                        if (confirm("Are you sure you want to delete?")) {
                            doPost("classifierTypesGridViewClik", key);
                        }
                    }
                    else {
                        doPost("classifierTypesGridViewClik", key);
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
            $("[id*=<%= classifierTypesGridView.ClientID %>] td").mousedown(function (e) {

                var selectedRowIndex = $(this).parent().index();
                var hiddField = document.getElementById('<%= selectedClassifierTypeIndexHiddenField.ClientID %>');
                hiddField.value = selectedRowIndex;

                var gridID = '<%= classifierTypesGridView.ClientID %>';
                ResetGridSelection(gridID);

                $(this).closest("tr").removeClass('odd');
                $(this).closest("tr").toggleClass("selectedRow");

                //1: left, 2: middle, 3: right

                switch (e.which) {
                    case 1:
                        doPost("classifierTypesGridViewClik", "select");
                        break;
                    case 3:
                        $(".context-menu-classifierTypes").contextMenu({ x: e.pageX, y: e.pageY });
                        break;
                }
            });
        });

        $(function () {
            $("#classifierTypedDIV").mousedown(function (e) {
                if (e.which == 3) {
                    $(".context-menu-classifierTypes").contextMenu({ x: e.pageX, y: e.pageY });
                }
            }); 
        });        


        $(function () {
            $.contextMenu({
                selector: '.context-menu-classifier',
                trigger: 'none',
                callback: function (key, options) {
                    if (key == "delete") {
                        if (confirm("Are you sure you want to delete?")) {
                            doPost("classifierGridViewClik", key);
                        }
                    }
                    else {
                        doPost("classifierGridViewClik", key);
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
            $("[id*=<%= classifiersGridView.ClientID %>] td").mousedown(function (e) {

                var selectedRowIndex = $(this).parent().index();
                var hiddField = document.getElementById('<%= classifiersGridViewSelectedIndexHiddenFiled.ClientID %>');
                hiddField.value = selectedRowIndex;

                var gridID = '<%= classifiersGridView.ClientID %>';
                ResetGridSelection(gridID);

                $(this).closest("tr").removeClass('odd');
                $(this).closest("tr").toggleClass("selectedRow");

                //1: left, 2: middle, 3: right

                switch (e.which) {
                    case 1:
                        //doPost("classifierGridViewClik", "select");
                        break;
                    case 3:
                        $(".context-menu-classifier").contextMenu({ x: e.pageX, y: e.pageY });
                        break;
                }
            });
        });

        $(function () {
            $("#classifiersDIV").mousedown(function (e) {
                if (e.which == 3) {
                    $(".context-menu-classifier").contextMenu({ x: e.pageX, y: e.pageY });
                }
            }); 
        });

    </script>

</asp:Content>

<asp:Content ID="ClassifiersContnet" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">
    <div class="grid_4 box context-menu-classifierTypes" id="classifierTypedDIV" style=" min-height:300px;">
        <h2>List Of Classifiers Types   <asp:ImageButton ID="refreshClassifirsTypesButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Show/Refresh" ImageUrl="../images/refresh.png"  runat="server" OnClick="refreshClassifirsTypesButton_Click" AlternateText="Show/Refresh list" /></h2>
                                                 
            <asp:HiddenField ID="selectedClassifierTypeIndexHiddenField" runat="server"></asp:HiddenField>
            <asp:GridView ID="classifierTypesGridView" runat="server" 
                    AutoGenerateColumns="False"
                    AlternatingRowStyle-CssClass="odd"
                    SelectedRowStyle-CssClass="selectedRow"
                    AllowPaging="false" 
                    onrowcreated="classifierTypesGridView_RowCreated"  >
                <Columns>
                    <asp:BoundField DataField="Type ID"  HeaderText="Type ID"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" HtmlEncode="False" />
                    <asp:BoundField DataField="Name"          HeaderText="Name"             HtmlEncode="False" />                                                    
                </Columns>
            </asp:GridView>


            <asp:HyperLink ID="clTypeHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

            <ajax:ModalPopupExtender ID="classifierTypePopupExtender" runat="server"     
                TargetControlID="clTypeHyperLink"
                PopupControlID = "classifierTypePanel" 
                PopupDragHandleControlID="legendClType"
                CancelControlID="classifierTypeCancelButton"
                DropShadow="true" >
            </ajax:ModalPopupExtender>   
                        

            <asp:Panel ID="classifierTypePanel" runat="server" class="box" Width="370px" Height="100px" style="display:none; border:1px solid #000;" >
                <h2 runat="server" id="legendClType"  style="cursor:move;">Classifier Type</h2>
       			<fieldset class="login">						
					<p>
						<label>Classifier Type Name: </label>
                        <asp:HiddenField ID="classiferTypeAction" runat="server" />  
                        <asp:HiddenField ID="selectedClassifierTypeIDHiddenField" runat="server" />                       
						<asp:TextBox ID="classifierTypeTextBox" runat="server"></asp:TextBox>
					</p>
                    <div style="  text-align: center;">
                        <asp:Button ID="classifierTypeSaveButton" runat="server" Text="Save" onclick="classifierTypeSaveButton_Click"   />
                        <asp:Button ID="classifierTypeCancelButton" runat="server" Text="Cancel"  />  
                    </div>

				</fieldset>
            </asp:Panel>
    </div>
    
    <div class="grid_8 box context-menu-classifier" id="classifiersDIV" style=" min-height:300px;">
        <h2>List Of Classifiers &nbsp;&nbsp; <asp:ImageButton ID="classifiersRefreshButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Show/Refresh" ImageUrl="../images/refresh.png"  runat="server" OnClick="classifiersRefreshButton_Click" AlternateText="Show/Refresh list" /></h2>

        <asp:Label ID="label" runat="server" Text="Selected Classifier Type: "></asp:Label>
        <asp:Label ID="curentClassifierTypeSelectedLabel" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="Large"></asp:Label>   
        <asp:HiddenField runat="server" ID="classifiersGridViewSelectedIndexHiddenFiled" />

        <asp:GridView ID="classifiersGridView" runat="server" 
            AutoGenerateColumns="False"
            SelectedRowStyle-CssClass="selectedRow"
            AlternatingRowStyle-CssClass="odd"
            AllowPaging="false" 
            onrowcreated="classifiersGridView_RowCreated"   >
            <Columns>
                <asp:BoundField DataField="Type ID"     HeaderText="Type ID"          HtmlEncode="False"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass = "hidden"  />
                <asp:BoundField DataField="Code"        HeaderText="Code"             HtmlEncode="False" />
                <asp:BoundField DataField="Name"        HeaderText="Name"             HtmlEncode="False" />
                <asp:BoundField DataField="GroupCode"   HeaderText="Group Code"       HtmlEncode="False" />                               
            </Columns>
        </asp:GridView>



        <asp:HyperLink ID="classifiersHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

        <ajax:ModalPopupExtender ID="classifersPopupExtender" runat="server"     
            TargetControlID="classifiersHyperLink"
            PopupControlID = "classifersPanel" 
            PopupDragHandleControlID="legendClassifiers"
            CancelControlID="classifiersCancelButton"
            DropShadow="true" >
        </ajax:ModalPopupExtender>   
                        

        <asp:Panel ID="classifersPanel" runat="server" class="box" Width="380px" Height="150px" style="display:none; border:1px solid #000;" >
            <h2 runat="server" id="legendClassifiers" style="cursor:move;">Classifier:</h2>
       		<fieldset class="login">					
				<p>
					<label>Classifier Name: </label>
                    <asp:HiddenField ID="classifiersActionHiddenField" runat="server" />  
                    <asp:HiddenField ID="currentClassifierSelectedHiddenFiled" runat="server" />                                              
                    <asp:TextBox ID="classifierNameTextBox" runat="server"></asp:TextBox>
				</p>
                <p>
                    <label> Group Code: </label>
                    <asp:TextBox ID="classifierGroupCodeTextBox" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="classifierGroupCodeTextBox" ErrorMessage="Please Enter Only Numbers" ValidationExpression="^\d+$" ValidationGroup="number"></asp:RegularExpressionValidator>                                 
                </p>
                <div style="  text-align: center;">
				    <asp:Button ID="classifiersSaveButton"  runat="server" Text="Save" onclick="classifiersSaveButton_Click" ValidationGroup="number"  />
                    <asp:Button ID="classifiersCancelButton"   runat="server" Text="Cancel" /> 
                </div> 
			</fieldset>
        </asp:Panel>
    </div>
</asp:Content>



