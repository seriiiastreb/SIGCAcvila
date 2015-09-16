<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClientSelectionControl.ascx.cs" Inherits="ClientSelectionControl" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Button runat="server" ID="hiddenTargetControlClientModalPopup" Style="display: none" />
<ajax:ModalPopupExtender 
    runat="server" 
    ID="clientModalPopup" 
    TargetControlID="hiddenTargetControlClientModalPopup" 
    PopupControlID="programmaticPopup"
    DropShadow="True" 
    PopupDragHandleControlID="programmaticPopupDragHandle"
    CancelControlID="cancelButton"
    RepositionMode="RepositionOnWindowScroll">
</ajax:ModalPopupExtender>

<asp:Panel runat="server" ID="programmaticPopup" CssClass="box" style="display:none; width:750px; border:1px solid #000;">
    <h2 style="cursor:move;" runat="server" id="programmaticPopupDragHandle">Client List  <asp:Image ID="cancelButton" runat="server" ImageUrl="~/images/dialog_close.png"  Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
    <fieldset>	
        <div style="height:270px; width:150px; overflow:auto; float:left;">
           
           <asp:RadioButton ID="juridicPersonRadio" runat="server" OnClick="GetCustomersList(0)" GroupName="clientSelecDialTypeCl" Text="Legal entity" Checked="true" />
           <br />
           <asp:RadioButton ID="fizicPersonRadio" runat="server" OnClick="GetCustomersList(0)" GroupName="clientSelecDialTypeCl" Text="Individualy" Checked="false" />
           <br /><br />
           <h5>Filter by Category</h5>
           <ul class="menu">
				<li>
					<a onclick="GetCustomersList(0)" style="cursor:pointer;">All customers</a>
				</li>
				<%--<li>
					<a onclick="GetCustomersList(1)" style="cursor:pointer;">Category 1</a>
				</li>
				<li>
					<a onclick="GetCustomersList(2)" style="cursor:pointer;">Category 2</a>
				</li>--%>
			</ul>        
        </div>

        <div  style="height:270px; width:560px;  overflow:auto; padding-left:15px;">
            <asp:Label ID="Label1" runat="server" Text="Live Filter"></asp:Label>
            <input type="text" runat="server" id="txtSearch" />   

           <div id="customersDiv" runat="server">
           </div>

        </div>

        <div style="text-align:center;">        
            <asp:HiddenField ID="selectedClientIDHiddenField" runat="server" />   
            <asp:Button ID="okButton" runat="server" Text="Ok" onclick="okButton_Click" Width="100px" CausesValidation="false" />
<%--            <asp:Button ID="addNewClientButton" runat="server" Text="Add new client" Width="100px" CausesValidation="false" OnClick="addNewClientButton_Click" />--%>
        </div>
    </fieldset>  
</asp:Panel>



  












