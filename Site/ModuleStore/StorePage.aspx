﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StorePage.aspx.cs" Inherits="StorePage" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">  

    <asp:Panel runat="server" ID="stokListPanel" class="grid_16 box" style="min-height:100px;" Visible="false">
        <h2>STOK &nbsp;&nbsp; &nbsp;&nbsp;<asp:ImageButton ID="uploadFromFileButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Upload From File" ImageUrl="../images/plus.png"  runat="server" OnClick="uploadFromFileButton_Click" AlternateText="Upload From File" /></h2>
        <asp:GridView ID="productsListGridView" runat="server" 
            AutoGenerateColumns="true"
            AlternatingRowStyle-CssClass="odd"
            AllowPaging="false"   >
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="uploadFromFilePanel" runat="server">
        <h2> Upload From excel file </h2>

        <fieldset>
            <label>Week:<asp:TextBox ID="weekTextBox" runat="server"></asp:TextBox>   &nbsp; &nbsp; &nbsp;  
            File sheet: <asp:DropDownList ID="fileSheetsDDL" runat="server" ></asp:DropDownList>        &nbsp; &nbsp; &nbsp;         
            File:&nbsp;<asp:FileUpload ID="excelFileUpload" runat="server" />  <asp:Button ID="openFileButton" runat="server" Text="Open File"  OnClick="openFileButton_Click"/> </label>
            &nbsp; &nbsp; &nbsp; 
            <asp:Button runat="server" Text="Back to Stok list" ID="backButton" OnClick="backButton_Click" />
            <br />
            <div style="max-height:600px; overflow-y:scroll;">
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
            </div>
            <br />

            <asp:Button  ID="confirmUploadButton" Text="Confirm Uppload" runat="server" OnClick="confirmUploadButton_Click" />

        </fieldset>
    
    </asp:Panel>


</asp:Content>

