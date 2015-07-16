<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Orders" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%--<%@ Register TagPrefix="csd" TagName="ClientSelectionControl" Src="~/Controls/ClientSelectionControl.ascx" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">   

    <div id="ordersDIV" class="grid_15 box" style="min-height:100px;">
        <h2>Registered orders list</h2>

        <asp:GridView ID="ordersListGridView" runat="server" 
            AutoGenerateColumns="true"
            AlternatingRowStyle-CssClass="odd"            
            AllowPaging="false"  
            SelectedRowStyle-CssClass = "selectedRow" >          
        </asp:GridView>
    </div>
    <div class="clear"></div> 
  
</asp:Content>

