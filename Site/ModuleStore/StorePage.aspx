﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StorePage.aspx.cs" Inherits="StorePage" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">  

    <asp:Panel runat="server" ID="StockListPanel" class="grid_16 box" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                gridviewScroll();
            });

            $(window).resize(function () {
                gridviewScroll();
            });

            function gridviewScroll() {
                gridView1 = $('#<%=StockListGridView.ClientID %>').gridviewScroll({
                    width: $(window).width() - 150,
                    height: $(window).height() - 200,
                    freezesize: 1,
                    headerrowcount: 1,
                });
            }
        </script> 

        <h2>Stock:
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="refreshButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Refresh" ImageUrl="../images/refresh.png"  runat="server" OnClick="refreshButton_Click" AlternateText="Refresh" /> 
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="uploadFromFileButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Upload From File" ImageUrl="../images/plus.png"  runat="server" OnClick="uploadFromFileButton_Click" AlternateText="Upload From File" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="generateCommandWeekDDL" runat="server" Height="16px"></asp:DropDownList>
            &nbsp;
            <asp:ImageButton ID="createOrdersButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Crearea comenzii in format excel" ImageUrl="../images/cartinput.png"  runat="server" OnClick="createOrdersButton_Click" AlternateText="Crearea comenzii in format excel" />
        
        </h2>
        <asp:GridView ID="StockListGridView" runat="server" 
            AutoGenerateColumns="true"
            AlternatingRowStyle-CssClass="odd"
            AllowPaging="false" OnRowDataBound="StockListGridView_RowDataBound"   >
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="uploadFromFilePanel" runat="server" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                gridviewScroll();
            });

            $(window).resize(function () {
                gridviewScroll();
            });

            function gridviewScroll() {
                gridView1 = $('#<%=uploadFileGridView.ClientID %>').gridviewScroll({
                    width: $(window).width() - 150,
                    height: $(window).height() - 200,
                    freezesize: 6,
                    headerrowcount: 1,
                });
            }
        </script> 

        <h2> Upload From excel file </h2>

        <fieldset>
            <label>
            <asp:DropDownList ID="destinationDDL" runat="server"></asp:DropDownList> 
                 &nbsp; &nbsp; &nbsp;  
                Week:<asp:DropDownList ID="weeksDDL" runat="server"></asp:DropDownList>  &nbsp; &nbsp; &nbsp;  
            File sheet: <asp:DropDownList ID="fileSheetsDDL" runat="server" ></asp:DropDownList>        &nbsp; &nbsp; &nbsp;         
            File:&nbsp;<asp:FileUpload ID="excelFileUpload" runat="server" />  <asp:Button ID="openFileButton" runat="server" Text="Open File"  OnClick="openFileButton_Click"/> </label>
            &nbsp; &nbsp; &nbsp; 
            <asp:Button runat="server" Text="Back to Stock list" ID="backButton" OnClick="backButton_Click" />
            <br />

            <asp:GridView ID="uploadFileGridView" runat="server" 
                AutoGenerateColumns="true"
                AlternatingRowStyle-CssClass="odd" HeaderStyle-BackColor="DarkGray"
                AllowPaging="false"   >
                <Columns>
                    <asp:TemplateField >
                        <HeaderTemplate>
                                <asp:CheckBox runat="server" ID="selectAllCheckBox" onclick = "CheckAllForGrid('ctl00_MainPlaceHolder_uploadFileGridView', this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="rowCheckBox" />
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Upload Status">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="resultUploadLabel" Text=""></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />

            <asp:Button  ID="confirmUploadButton" Text="Confirm Uppload" runat="server" OnClick="confirmUploadButton_Click" />

        </fieldset>
    
    </asp:Panel>

</asp:Content>

