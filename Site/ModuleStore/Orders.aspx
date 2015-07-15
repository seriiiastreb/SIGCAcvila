<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Orders" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%--<%@ Register TagPrefix="csd" TagName="ClientSelectionControl" Src="~/Controls/ClientSelectionControl.ascx" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">   

    <div id="ordersDIV" class="grid_15 box" style="min-height:100px;">
        <h2>registered orders list</h2>

        <asp:GridView ID="ordersListGridView" runat="server" 
            AutoGenerateColumns="false"
            AlternatingRowStyle-CssClass="odd"
            OnRowCreated="ordersListGridView_RowCreated"
            AllowPaging="false"  
            SelectedRowStyle-CssClass = "selectedRow" 
            onselectedindexchanged="ordersListGridView_SelectedIndexChanged" >
            <Columns>
                <asp:BoundField DataField="order_id" HeaderText="OrderID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                <asp:BoundField DataField="client_description" HeaderText="Client" />
                <asp:BoundField DataField="nr" HeaderText="Nr." />
                <asp:BoundField DataField="state_name" HeaderText="State" />
                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                        <asp:Label ID="dateLabel" Width="100px" runat="server" Text='<%# ((Eval("date") != null && Eval("date") is DateTime) ?  ((DateTime)Eval("date")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>  
                <asp:BoundField DataField="Total Comandat" HeaderText="Total Comandat"  />     
                <asp:BoundField DataField="Total livrat" HeaderText="Total livrat" />
                <asp:BoundField DataField="Diferenta" HeaderText="Diferenta" />                                                       
            </Columns>
        </asp:GridView>
    </div>
    <div class="clear"></div>

    <asp:Panel ID="ordersWorkPanel" runat="server" CssClass="grid_15 box" Visible="false">
    <h2>Order description</h2>
          <asp:GridView ID="orderDetailsGridView" runat="server" 
            AutoGenerateColumns="false"
            AlternatingRowStyle-CssClass="odd"            
            AllowPaging="false"   >
            <Columns>
                <asp:BoundField DataField="articol_name" HeaderText="Articol"  />
                <asp:BoundField DataField="desen_name" HeaderText="Desen"  />
                <asp:BoundField DataField="tip_name" HeaderText="Tip" />
                <asp:BoundField DataField="colorit_name" HeaderText="Colorit" />
                <asp:BoundField DataField="latime" HeaderText="Latime" />
                <asp:BoundField DataField="lungime" HeaderText="Latime" />     
                <asp:BoundField DataField="metraj" HeaderText="Metraj" />                                                                         
                <asp:BoundField DataField="bucati" HeaderText="Bucati" />    
                <asp:BoundField DataField="festonare_name" HeaderText="Festonare" />    
                <asp:BoundField DataField="ean13" HeaderText="EAN13" />  
            </Columns>
        </asp:GridView>
                                   
    </asp:Panel>  

</asp:Content>

