<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NFileBrowser.ascx.cs" Inherits="Controls_NFileBrowser" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Assembly="IZ.WebFileManager" Namespace="IZ.WebFileManager" TagPrefix="iz" %>

<asp:Button runat="server" ID="hiddenTargetControl" Style="display: none" />
<ajax:ModalPopupExtender 
    runat="server" 
    ID="modalPopup" 
    TargetControlID="hiddenTargetControl" 
    PopupControlID="programmaticPopup"
    CancelControlID="cancelButton"
    DropShadow="True" 
    PopupDragHandleControlID="programmaticPopupDragHandle"
    RepositionMode="RepositionOnWindowResizeAndScroll">
</ajax:ModalPopupExtender>

<asp:Panel runat="server" ID="programmaticPopup" Width="820" Height="460" Style=" background-color:white; border: 1px solid Gray; display:none;"  >
    <div runat="server" ID="programmaticPopupDragHandle" style="border: 1px solid black; text-align:center; font-size:15pt; background-color:Lime; text-transform:uppercase; cursor: move; " >
          <b> <asp:Label ID="WindowTitleLabel" runat="server" Text="File Browser"></asp:Label> </b>
    </div>        
        
    <iz:FileManager ID="FileManager" runat="server" Height="400px" Width="812" AllowUpload="false">
        <RootDirectories>
            <iz:RootDirectory DirectoryPath="~/Files" Text="Files" />
        </RootDirectories>
    </iz:FileManager>

    <div style="float:left; width:80%; margin-top:3px;">
        <asp:FileUpload ID="FileUpload1" runat="server"  AllowMultiple="true"  />
        <asp:Button ID="uploadButtonButton" runat="server" Text="Upload" OnClick="uploadButtonButton_Click"  CausesValidation="false" />       
    </div>

    <div style="float:right; margin-top:3px;">   
        <asp:Button ID="cancelButton" runat="server" Text="Close" Width="100px" OnClick="cancelButton_Click" CausesValidation="false"  />
    </div>

</asp:Panel>


