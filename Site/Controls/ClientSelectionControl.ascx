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

<asp:Panel runat="server" ID="programmaticPopup" CssClass="box" style="width:750px; border:1px solid #000;">
    <h2 style="cursor:move;" runat="server" id="programmaticPopupDragHandle">Client List  <asp:Image ID="cancelButton" runat="server" ImageUrl="~/images/dialog_close.png"  Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
    <fieldset>	

        <div style="height:270px; width:150px; overflow:auto; float:left;">
            <h5>A menu</h5>
           <ul class="menu">
				<li>
					<a href="#">Item 1</a>
				</li>
				<li>
					<a href="#">Item 2</a>
				</li>
				<li>
					<a href="#">Item 3</a>
				</li>
			</ul>        
        </div>

        <div  style="height:270px; width:560px;  overflow:auto; padding-left:15px;">
            <asp:Label ID="Label1" runat="server" Text="Live Filter"></asp:Label>
            <input type="text" runat="server" id="txtSearch" />   

            <table>
				<tbody>
                    <tr>
					    <th>Lorem ipsum</th>
					    <td>Dolor sit</td>
					    <td class="currency">$125.00</td>
				    </tr>
				    <tr>
					    <th>Dolor sit</th>
					    <td>Nostrud exerci</td>
					    <td class="currency">$75.00</td>
				    </tr>
				    <tr>
					    <th>Nostrud exerci</th>
					    <td>Lorem ipsum</td>
					    <td class="currency">$200.00</td>
				    </tr>
				    <tr>
					    <th>Lorem ipsum</th>
					    <td>Dolor sit</td>
					    <td class="currency">$64.00</td>
				    </tr>
				    <tr>
					    <th>Dolor sit</th>
					    <td>Nostrud exerci</td>
					    <td class="currency">$36.00</td>
				    </tr>
			    </tbody>
            </table>

        </div>

        <div style="text-align:center;">        
            <asp:HiddenField ID="selectedClientIDHiddenField" runat="server" />   
          <%--  <asp:Button ID="okButton" runat="server" Text="Ok" onclick="okButton_Click" Width="100px" CausesValidation="false" />--%>
        </div>
    </fieldset>  
</asp:Panel>



  












