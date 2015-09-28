<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Produse.aspx.cs" Inherits="Produse" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server">   

 <script type="text/javascript" language="javascript">

       $(function () {
           $.contextMenu({
               selector: '.context-menu-products',
               trigger: 'none',
               callback: function (key, options) {
                   if (key == "delete") {
                       if (confirm("Are you sure you want to delete?")) {
                           doPost("productsListGridViewClik", key);
                       }
                   }
                   else {
                       doPost("productsListGridViewClik", key);
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
           $("[id*=<%= productsListGridView.ClientID %>] td").mousedown(function (e) {

               var selectedRowIndex = $(this).parent().index();
               var hiddField = document.getElementById('<%= selectedProductsListGridViewIndexHiddenField.ClientID %>');
               hiddField.value = selectedRowIndex;

               var gridID = '<%= productsListGridView.ClientID %>';
               ResetGridSelection(gridID);

               $(this).closest("tr").removeClass('odd');
               $(this).closest("tr").toggleClass("selectedRow");

               //1: left, 2: middle, 3: right

               switch (e.which) {
                   case 1:
                       doPost("productsListGridViewClik", "select");
                       break;
                   case 3:
                       $(".context-menu-products").contextMenu({ x: e.pageX, y: e.pageY });
                       break;
               }
           });
       });

       $(function () {
           $("#<%= productsPanel.ClientID %>").mousedown(function (e) {
               if (e.which == 3) {
                   $(".context-menu-products").contextMenu({ x: e.pageX, y: e.pageY });
               }
           });
       });        
        

    </script> 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server">  
 <asp:Panel runat="server" id="productsPanel" CssClass="grid_16 box context-menu-products" style="min-height:100px; max-height:650px; overflow-y:scroll;" Visible="false">
        <h2>Registered Products List &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:ImageButton ID="refreshButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Refresh" ImageUrl="../images/refresh.png"  runat="server" OnClick="refreshButton_Click" AlternateText="Refresh" /> 
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:ImageButton ID="uploadFromFileButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Upload From File" ImageUrl="../images/plus.png"  runat="server" OnClick="uploadFromFileButton_Click" AlternateText="Upload From File" /> </h2>
        <asp:HiddenField ID="selectedProductsListGridViewIndexHiddenField" runat="server"></asp:HiddenField>

       <script language="javascript" type="text/javascript">
           $(document).ready(function () {
               gridviewProdScroll();
           });

           $(window).resize(function () {
               gridviewProdScroll();
           });

           function gridviewProdScroll() {
               gridView1 = $('#<%=productsListGridView.ClientID %>').gridviewScroll({
                   width: $(window).width() - 150,
                   height: $(window).height() - 200,
                   freezesize: 0,
                   headerrowcount: 1,
               });
           }
       </script>

        <asp:GridView ID="productsListGridView" runat="server" 
            AutoGenerateColumns="false"
            AlternatingRowStyle-CssClass="odd"
            OnRowCreated="productsListGridView_RowCreated"
            AllowPaging="false"  
            SelectedRowStyle-CssClass = "selectedRow" >
            <Columns>
                <asp:BoundField DataField="product_id" HeaderText="product_id" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                <asp:BoundField DataField="articol" HeaderText="articol" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                <asp:BoundField DataField="articol_name" HeaderText="Articol" />
                <asp:BoundField DataField="desen" HeaderText="desen" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />             
                <asp:BoundField DataField="desen_name" HeaderText="Desen" />              
                <asp:BoundField DataField="tip" HeaderText="tip" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />             
                <asp:BoundField DataField="tip_name" HeaderText="Tip" />   
                <asp:BoundField DataField="colorit" HeaderText="colorit" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />             
                <asp:BoundField DataField="colorit_name" HeaderText="Colorit" />                 
                <asp:BoundField DataField="latime" HeaderText="Latime" />      
                <asp:BoundField DataField="lungime" HeaderText="Lungime" />                  
            </Columns>
        </asp:GridView>
    </asp:Panel>


    <asp:HyperLink ID="productsHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

    <ajax:ModalPopupExtender ID="productPopupExtender" runat="server"     
        TargetControlID="productsHyperLink"
        PopupControlID = "productWorkPanel" 
        PopupDragHandleControlID="productHeader"
        CancelControlID="productCancelButton"
        DropShadow="true" >
    </ajax:ModalPopupExtender>   

    <asp:Panel ID="productWorkPanel" runat="server" CssClass="grid_8 box" Style=" width:300px; display:none;">
        <h2 runat="server" id="productHeader"  style="cursor:move;">Product description</h2>
        <fieldset >  		      
           <p>
                <asp:HiddenField ID="productActionHiddenField" runat="server" />
                <asp:HiddenField ID="productIDHiddenField" runat="server" />
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
            <div style="margin:auto; width:201px;">
                <asp:Button ID="saveProductDetailsButton" runat="server"  Text="Save" OnClick="saveProductDetailsButton_Click" />
                <asp:Button ID="productCancelButton" runat="server"  Text="Cancel"  />
            </div>
	    </fieldset>           
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
                    freezesize: 0,
                    headerrowcount: 1,
                });
            }
        </script> 
        <h2> Upload From excel file </h2>

        <fieldset>
            <label>
            File sheet: <asp:DropDownList ID="fileSheetsDDL" runat="server" ></asp:DropDownList>        &nbsp; &nbsp; &nbsp;         
            File:&nbsp;<asp:FileUpload ID="excelFileUpload" runat="server" />  <asp:Button ID="openFileButton" runat="server" Text="Open File"  OnClick="openFileButton_Click"/> </label>
            &nbsp; &nbsp; &nbsp; 
            <asp:Button runat="server" Text="Back to Products list" ID="backButton" OnClick="backButton_Click" />
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

