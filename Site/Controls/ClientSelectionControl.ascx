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

<asp:Panel runat="server" ID="programmaticPopup" Width="820px"  Style=" background-color: white; border: 1px solid Gray; display: none; position: absolute; top: 30%; left:30%;" >

    <div runat="server" ID="programmaticPopupDragHandle" style="border: 1px solid black; text-align:center; font-size:15pt; background-color:Lime; text-transform:uppercase; cursor: move; " >
          <b> <asp:Label ID="WindowTitleLabel" runat="server" Text="CONTRAGENTI EXISTENTI"></asp:Label> </b>
    </div>        
        <asp:UpdatePanel runat="server" ID="ClientSelectionDialogUpdatePanel" >
        <ContentTemplate>   

            <div style="height:270px; width:150px; overflow:auto; float:left;">
                <asp:TreeView runat="server" ID="clientCategoriesTreeView" ShowLines="true" onselectednodechanged="clientCategoriesTreeView_SelectedNodeChanged" >
                    <Nodes>
                        <asp:TreeNode Value="0" 
                            Text="All List" 
                            Expanded="True">
                        </asp:TreeNode>
                    </Nodes>
                </asp:TreeView>
            </div>
            <div style="height:20px; width:650px;float:left;"> 
                <asp:Label ID="Label1" runat="server" Text="Live Filter"></asp:Label>
                <input type="text" runat="server" id="txtSearch" style="width:550px;" runat="server" />    
            </div>

            <div style="height:250px; width:650px; overflow:auto;  float:left; margin-top:5px;" runat="server" id="clientsListDiv"  >               
                <asp:UpdatePanel runat="server" ID="clinetUpdatePanel">
                    <ContentTemplate>
                        <asp:GridView ID="clientiGridView" runat="server" 
                            AutoGenerateColumns="False" 
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            AllowPaging="false" 
                            SelectedRowStyle-BackColor="#CCCCFF"
                            onrowdatabound="clientiGridView_RowDataBound" 
                            onselectedindexchanged="clientiGridView_SelectedIndexChanged" 
                            Width="100%" >
                            <Columns>
                                <asp:BoundField DataField="clientID" ItemStyle-Width = "100px" HeaderStyle-CssClass ="HiddenColumn" ItemStyle-CssClass="HiddenColumn" HtmlEncode="False" />
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" ItemStyle-Width = "150px" HtmlEncode="False" />
                                <asp:BoundField DataField="LastName" HeaderText="LastName" ItemStyle-Width = "150px" HtmlEncode="False" />
                
                                <asp:TemplateField HeaderText="Data Nastere">
                                    <ItemTemplate>
                                        <asp:Label ID="dateOfBirthLabel" Width="100px" runat="server" Text='<%# ((Eval("DateOfBirth") != null && Eval("DateOfBirth") is DateTime) ?  ((DateTime)Eval("DateOfBirth")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                
                                <asp:BoundField DataField="buletinSeria" HeaderText="Buletin" ItemStyle-Width = "150px" HtmlEncode="False" />
                                <asp:BoundField DataField="personalID" HeaderText="Personal ID" ItemStyle-Width = "150px" HtmlEncode="False" /> 
                                <asp:BoundField DataField="telefon" HeaderText="Telefon" ItemStyle-Width = "150px" HtmlEncode="False" />                                                  
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>                  
                </asp:UpdatePanel>                   
            </div>         

        </ContentTemplate>
    </asp:UpdatePanel>  
    <br /> <br />
    <div style="text-align:center;">        
        <asp:HiddenField ID="selectedClientIDInCSCHiddenField" runat="server" />
        <asp:HiddenField ID="selectedClientFirstNameHiddenField" runat="server" />
        <asp:HiddenField ID="SelectedClientLastNameHiddenField" runat="server" />
        <asp:HiddenField ID="SelectedClientIDNOHiddenField" runat="server" />
        <asp:HiddenField ID="SelectedClientBirthDateHiddenField" runat="server" />

        <asp:Button ID="okButton" runat="server" Text="Ok" onclick="okButton_Click" Width="100px" CausesValidation="false" />
        <asp:Button ID="cancelButton" runat="server" Text="Cancel" Width="100px" />
    </div>

</asp:Panel>



  












