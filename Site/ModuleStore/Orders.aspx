<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Orders" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register TagPrefix="csd" TagName="ClientSelectionControl" Src="~/Controls/ClientSelectionControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 
    <script type="text/javascript">
        $(document).ready(function () {
            gridviewScroll();
        });

        $(window).resize(function () {
            gridviewScroll();
        });

        function gridviewScroll() {
            gridView1 = $('#<%=ordersListGridView.ClientID %>').gridviewScroll({
                width: $(window).width() - 150,
                height: $(window).height() - 200 ,
                freezesize: 6,
                headerrowcount: 1,
            });
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">   

    <asp:Panel id="ordersPanel" runat="server" cssclass="grid_15 box" style="min-height:100px;" Visible="false">
        <h2>Registered orders list</h2>

        <asp:GridView ID="ordersListGridView" runat="server" 
            AutoGenerateColumns="true"
            AlternatingRowStyle-CssClass="odd"            
            AllowPaging="false"  
            SelectedRowStyle-CssClass = "selectedRow" >          
        </asp:GridView>
    </asp:Panel>

    <csd:ClientSelectionControl ID="customerSelectionControl" runat="server" OnOnClientSelected="customerSelectionControl_OnClientSelected" />
</asp:Content>

