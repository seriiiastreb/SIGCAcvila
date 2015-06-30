<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StorePage.aspx.cs" Inherits="StorePage" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">  

    <asp:Panel runat="server" ID="stokListPanel" class="grid_16 box" style="min-height:100px;">
        <h2>STOK &nbsp;&nbsp; &nbsp;&nbsp;<asp:ImageButton ID="uploadFromFileButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Upload From File" ImageUrl="../images/refresh.png"  runat="server" OnClick="uploadFromFileButton_Click" AlternateText="Upload From File" /></h2>
        <asp:GridView ID="productsListGridView" runat="server" 
            AutoGenerateColumns="true"
            AlternatingRowStyle-CssClass="odd"
            AllowPaging="false"   >
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="uploadFromFilePanel" runat="server">
        <h2> Upload From excel file </h2>

        <fieldset>
            <label>Open File: </label>
        </fieldset>
    
    </asp:Panel>


</asp:Content>

