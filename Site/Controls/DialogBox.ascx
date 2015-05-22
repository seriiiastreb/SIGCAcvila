<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DialogBox.ascx.cs" Inherits="Controls_DialogBox" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Button runat="server" ID="hiddenTargetControlForModalPopup" Style="display: none" />
<ajax:ModalPopupExtender 
    runat="server" 
    ID="programmaticModalPopup" 
    TargetControlID="hiddenTargetControlForModalPopup" 
    PopupControlID="programmaticPopup"
    DropShadow="True" 
    PopupDragHandleControlID="programmaticPopupDragHandle"
    RepositionMode="RepositionOnWindowResizeAndScroll">
</ajax:ModalPopupExtender>

<asp:Panel runat="server" ID="programmaticPopup" Style="display: none;">

    <div runat="server" ID="programmaticPopupDragHandle" >
        <asp:Label ID="infoBoxTitleLabel" runat="server" Text=""></asp:Label>
    </div>        
    <div runat="server" id="bodyMessageDiv">
        <asp:Label ID="infoBoxMessageLabel" runat="server" Text=""></asp:Label> 
    </div>   
    <div style="clear:both;"></div>  
    <div style="text-align:center;" >
        <asp:Button ID="infoBoxOkButton" runat="server" Text="Ok" Width="150px" />
    </div>

</asp:Panel>