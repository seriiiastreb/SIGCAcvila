<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Orders" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register TagPrefix="csd" TagName="ClientSelectionControl" Src="~/Controls/ClientSelectionControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 

   <script type="text/javascript" language="javascript">

       $(function () {
           $.contextMenu({
               selector: '.context-menu-orders',
               trigger: 'none',
               callback: function (key, options) {
                   if (key == "delete") {
                       if (confirm("Are you sure you want to delete?")) {
                           doPost("ordersListGridViewClik", key);
                       }
                   }
                   else {
                       doPost("ordersListGridViewClik", key);
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
           $("[id*=<%= ordersListGridView.ClientID %>] td").mousedown(function (e) {

               var selectedRowIndex = $(this).parent().index();
               var hiddField = document.getElementById('<%= selectedOrdersListGridViewIndexHiddenField.ClientID %>');
               hiddField.value = selectedRowIndex;

               var gridID = '<%= ordersListGridView.ClientID %>';
               ResetGridSelection(gridID);

               $(this).closest("tr").removeClass('odd');
               $(this).closest("tr").toggleClass("selectedRow");

               //1: left, 2: middle, 3: right

               switch (e.which) {
                   case 1:
                       doPost("ordersListGridViewClik", "select");
                       break;
                   case 3:
                       $(".context-menu-orders").contextMenu({ x: e.pageX, y: e.pageY });
                       break;
               }
           });
       });

       $(function () {
           $("#ordersDIV").mousedown(function (e) {
               if (e.which == 3) {
                   $(".context-menu-orders").contextMenu({ x: e.pageX, y: e.pageY });
               }
           });
       });        

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">   

<div id="ordersDIV" class="box context-menu-orders" style="min-height:100px;">
<h2>registered orders list</h2>
    <asp:HiddenField ID="selectedOrdersListGridViewIndexHiddenField" runat="server"></asp:HiddenField>
    <asp:GridView ID="ordersListGridView" runat="server" 
        AutoGenerateColumns="false"
        AlternatingRowStyle-CssClass="odd"
        OnRowCreated="ordersListGridView_RowCreated"
        AllowPaging="false"  
        SelectedRowStyle-CssClass = "selectedRow" >
        <Columns>
            <asp:BoundField DataField="order_id" HeaderText="OrderID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="nr" HeaderText="Nr." />
            <asp:BoundField DataField="state_name" HeaderText="State" />
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="dateLabel" Width="100px" runat="server" Text='<%# ((Eval("date") != null && Eval("date") is DateTime) ?  ((DateTime)Eval("date")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>  
            <asp:BoundField DataField="metraj" HeaderText="Metraj" />
            <asp:BoundField DataField="bucati" HeaderText="Bucati"  />                                                 
        </Columns>
    </asp:GridView>
</div>

<div class="clear"></div>
<asp:Panel ID="ordersWorkPanel" runat="server" CssClass="grid_16 box" Visible="false">

            <h2>Order description</h2>

            <div class="grid_5">
                <fieldset >
                    <p>
                        <label>State:</label>
                        <asp:DropDownList ID="orderStateDDL" runat="server"></asp:DropDownList>
                    </p> 
                    <p>
                        <label>Date:</label>
                        <asp:TextBox ID="orderDateTextBox" runat="server"></asp:TextBox>                        
                        <ajax:CalendarExtender ID="orderDateCalendarExtender" runat="server" TargetControlID="orderDateTextBox"></ajax:CalendarExtender>
                    </p> 
                    <p>
                        <label>Solicitant:</label>
                        <asp:TextBox ID="orderSolicitantDescriptionTextBox" runat="server" Enabled="false" ReadOnly="true"></asp:TextBox>
                    </p>
		            <p>
                        <label>Nr:</label>
                        <asp:TextBox ID="orderNrTextBox" runat="server"></asp:TextBox>
                    </p>
                    <p>
                        <label>Articol:</label>
                        <asp:DropDownList ID="orderArticolDDL" runat="server"></asp:DropDownList>
                    </p>
                    <p>
                        <label>Desen:</label>
                        <asp:DropDownList ID="orderDesenDDL" runat="server"></asp:DropDownList>
                    </p>           
                    <p>
                        <label>Tip:</label>
                        <asp:DropDownList ID="orderTipDDL" runat="server"></asp:DropDownList>
                    </p>            

	            </fieldset>
            </div>	
            
            <div class="grid_5">
                <fieldset >
                    <p>
                        <label>Colorit:</label>
                        <asp:DropDownList ID="orderColoritDDL" runat="server"></asp:DropDownList>
                    </p>    
                    <p>
                        <label>Latime:</label>
                        <asp:TextBox ID="orderLatimeTextBox" runat="server"></asp:TextBox>
                    </p>    
                    <p>
                        <label>Lungime:</label>
                        <asp:TextBox ID="orderLungimeTextBox" runat="server"></asp:TextBox>
                    </p>    
                    <p>
                        <label>Bucati:</label>
                        <asp:TextBox ID="orderBucatiTextBox" runat="server"></asp:TextBox>
                    </p>    
                    <p>
                        <label>Metraj:</label>
                        <asp:TextBox ID="orderMetrajTextBox" runat="server"></asp:TextBox>
                    </p>   
		            <p>
                        <label>Festonare:</label>
                        <asp:DropDownList ID="orderFestonareDDL" runat="server"></asp:DropDownList>
                    </p>   
                    <p>
                        <label>EAN13:</label>
                        <asp:TextBox ID="orderEAN13TextBox" runat="server"></asp:TextBox>
                    </p>   
	            </fieldset>
            </div>	
               
    </asp:Panel>

    <div class="clear"></div>
    <div style="margin:auto; width:200px;">
        <asp:Button ID="saveOrderDetailsButton" runat="server" Width="200px" Text="Save Order details" OnClick="saveOrderDetailsButton_Click" />
    </div>


 

    <asp:HyperLink ID="newOrderHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

    <ajax:ModalPopupExtender ID="newOrderPopupExtender" runat="server"     
        TargetControlID="newOrderHyperLink"
        PopupControlID = "newOrderPanel" 
        PopupDragHandleControlID="newOrderHeader"
        CancelControlID="order_CancelButton"
        DropShadow="true" >
    </ajax:ModalPopupExtender>   

    <asp:Panel runat="server" ID="newOrderPanel" CssClass="grid_5 box" style="display:none; width: auto; border:1px solid #000;">
        <h2 style="cursor:move;" runat="server" id="newOrderHeader">New Order<asp:Image ID="order_CancelButton" runat="server" ImageUrl="~/images/dialog_close.png"  Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;"/></h2>
        <fieldset>
            <p>
                <label>Solicitant:</label>
                <asp:TextBox ID="newOrderClientInfoTextBox" runat="server" Enabled="false" ReadOnly="true"></asp:TextBox>
            </p>
        	<p>
                <label>Date:</label>
                <asp:TextBox ID="newOrderDateTextBox" runat="server"></asp:TextBox>
                <ajax:CalendarExtender ID="newOrderDateCalendarExtender" runat="server" TargetControlID="newOrderDateTextBox"></ajax:CalendarExtender>
            </p>
        	<p>
                <label>State:</label>
                <asp:DropDownList ID="newOrderStateDDL" runat="server" Enabled="false"></asp:DropDownList>
            </p>  
            <p>
                <label>Metraj:</label>
                <asp:TextBox ID="newOrderMetrajTextBox" runat="server"></asp:TextBox>
            </p>    
            <p>
                <label>Bucati:</label>
                <asp:TextBox ID="newOrderBucatiTextBox" runat="server"></asp:TextBox>
            </p>   

            <div style="text-align:right;">
                <asp:Button runat="server" ID="newOrderSaveBurtton" Text="Save" onclick="newOrderSaveBurtton_Click"  Width="100px"  />
            </div>
        </fieldset>
    </asp:Panel>

  <csd:ClientSelectionControl ID="customerSelectionControl" runat="server" OnOnClientSelected="customerSelectionControl_ClientSelected"  />

</asp:Content>

