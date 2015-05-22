<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ClientInfo.ascx.cs" Inherits="Controls_ClientInfo" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Button runat="server" ID="hiddenTargetControlForModalPopup" Style="display: none" />
<ajax:ModalPopupExtender 
    runat="server" 
    ID="programmaticModalPopup" 
    TargetControlID="hiddenTargetControlForModalPopup" 
    PopupControlID="programmaticPopup"
    DropShadow="True" 
    PopupDragHandleControlID="programmaticPopupDragHandle"
    OkControlID="infoBoxOkButton"
    RepositionMode="RepositionOnWindowResizeAndScroll">
</ajax:ModalPopupExtender>

<asp:Panel runat="server" ID="programmaticPopup" Style=" width:500px; height:300px; background-color: white; border: 1px solid Gray; display: none; position: absolute; top: 30%; left:30%;" >

    <div runat="server" ID="programmaticPopupDragHandle" style="border: 1px solid black; text-align:center; font-size:15pt; background-color:Lime; text-transform:uppercase; cursor: move; " >
        <asp:Label ID="infoBoxTitleLabel" runat="server" Text=""></asp:Label>
    </div>        

    <div runat="server" id="bodyMessageDiv">
        <div style="float:left; width:240px; height:240px" >
            <asp:Image ID="clientImage" runat="server"  />  
        </div>
        <div runat="server" style="float:left; width:260px;" class="groupDataPanel">
            <dl>         
                <dt class="part">Numele: </dt>
                <dd class="part"><asp:TextBox ID="clientNumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

                <dt class="inpart">Prenumele: </dt>
                <dd class="inpart"><asp:TextBox ID="clientPrenumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

                <dt class="part">Data Nasterii: </dt>
                <dd class="part">
                    <asp:TextBox ID="clientDateOfBirthTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                    <ajax:CalendarExtender ID="clientDateOfBirthCalendarExtender" runat="server"  TargetControlID="clientDateOfBirthTextBox" />
                </dd>
                
                <dt class="inpart">Locul Nasterii: </dt>
                <dd class="inpart">
                    <asp:TextBox ID="clientPlaseOfBirthTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                </dd>
   
                <dt class="part">Telefon Fix:</dt>
                <dd class="part"><asp:TextBox ID="addNewClientTelefonFixTextBox" runat="server" MaxLength="20" CssClass="microElement"></asp:TextBox></dd>
            
                <dt class="inpart">Telefon mobil:</dt>
                <dd class="inpart"><asp:TextBox ID="addNewClientTelefonMobilTextBox" runat="server" MaxLength="20" CssClass="microElement"/></dd>
 
                <dt class="part">Telefon mobil 2:</dt>
                <dd class="part"><asp:TextBox ID="addNewClientTelefonMobil2TextBox" runat="server" MaxLength="20" CssClass="microElement"/></dd>

                <dt class="inpart">Email:</dt>
                <dd class="inpart"><asp:TextBox ID="addNewClientEmailTextBox" runat="server" CssClass="microElement"/></dd>

                <dt class="part">Tara:</dt>
                <dd class="part">
                    <asp:DropDownList ID="rAddressClientCountryDDL" runat="server"  AutoPostBack="true"  Enabled="false"  CssClass="microDDL"/></dd>

                <dt class="inpart">Raionul: </dt>
                <dd class="inpart">
                    <asp:DropDownList ID="rAddressClientRaionDDL" runat="server" Enabled="false" CssClass="microDDL"/></dd>

                <dt class="part">Urban / Rural : </dt>
                <dd class="part">
                    <asp:DropDownList ID="rAddressUrbanRuralDDL" runat="server" CssClass="microDDL" Enabled="false">
                        <asp:ListItem Text="**"  Value=""/>
                        <asp:ListItem Text="Rural"  Value="Rural" />
                        <asp:ListItem Text="Urban"  Value="Urban"/>
                    </asp:DropDownList>
                </dd>

                <dt class="inpart">Localitatea: </dt>
                <dd class="inpart">
                    <asp:TextBox ID="rAddressClientLocalitateaTextBox" runat="server" CssClass="microElement"/></dd>

                <dt class="part">Adresa/Strada: </dt>
                <dd class="part">
                    <asp:TextBox ID="rAddressAddresaStradaTextBox" runat="server" CssClass="microElement"/></dd>
            </dl>
        </div>
    </div>   

    <div style="clear:both;"></div>  
    <div style="text-align:center;" >
        <asp:Button ID="infoBoxOkButton" runat="server" Text="Ok" Width="150px" />
    </div>

</asp:Panel>