<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Email.ascx.cs" Inherits="Controls_Email" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Button runat="server" ID="hiddenTargetControlForModalPopup" Style="display: none" />

<ajax:ModalPopupExtender 
    runat="server" 
    ID="programmaticModalPopup" 
    TargetControlID="hiddenTargetControlForModalPopup" 
    PopupControlID="emailPopup"
    DropShadow="True" 
    PopupDragHandleControlID="programmaticPopupDragHandle"
    OkControlID="closeButton"
    RepositionMode="RepositionOnWindowResizeAndScroll">
</ajax:ModalPopupExtender>

<asp:Panel runat="server" ID="emailPopup" Style="border: 1px solid Gray; padding:5px 5px 5px 5px; width:1000px; height:500px; background-color:white; display: none;" >

    <div runat="server" ID="programmaticPopupDragHandle" style="height:25px; background-color:#919191; margin-bottom:5px; cursor: move;" >
        <div style="text-align:center; float:left; width:960px; text-transform:uppercase; margin-top:5px; font-weight: bold;"> 
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:Label ID="infoBoxTitleLabel" runat="server" Text=""></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>      
            <asp:HiddenField ID="currentMailBoxUsserHiddenVield" runat="server" />
        </div>
        <div style="float:right; text-align:right; width:20px; padding-right:5px;">
            <asp:ImageButton ID="closeButton" BorderWidth="0px" ImageAlign="Middle" Width="16px" ToolTip="Close" ImageUrl="~/app_images/blackwhite_delete.png"  runat="server" AlternateText="Close" />
        </div>
    </div>        
    <div style="clear:both;"></div>

    <asp:UpdatePanel runat="server" ID="emailUpdatePanel">
        <ContentTemplate>
            <div style="width:130px; height:460px; float:left; border: 1px solid; border-radius: 10px; padding:5px; ">
                <table>
                    <tr>
                        <td><asp:ImageButton ID="inboxImagexButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="25px" ToolTip="Inbox" ImageUrl="~/App_Images/mail-folder-inbox-icon.png"  runat="server" OnClick="inboxLinkButton_Click" AlternateText="Inbox" /></td>
                        <td><asp:LinkButton ID="inboxLinkButton" runat="server" Text="Inbox" OnClick="inboxLinkButton_Click"></asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td><asp:ImageButton ID="composeImageButton" BorderWidth="0px" ImageAlign="AbsMiddle" Width="25px" ToolTip="New Email" ImageUrl="~/App_Images/mail-write-pen-icon.png"  runat="server" OnClick="composeLinkButton_Click" AlternateText="New Email" /></td>
                        <td><asp:LinkButton ID="composeLinkButton" runat="server" Text="Compose" OnClick="composeLinkButton_Click"></asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td><asp:ImageButton ID="sendedMailsImageButton" BorderWidth="0px"   ImageAlign="AbsMiddle" Width="25px" ToolTip="Sended Mails" ImageUrl="~/App_Images/mail-arrow-right-icon.png"  runat="server" OnClick="sendedMailsLinkButton_Click" AlternateText="Sended Mails" /></td>
                        <td><asp:LinkButton ID="sendedMailsLinkButton" runat="server" Text="Sended Items" OnClick="sendedMailsLinkButton_Click"></asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td><asp:ImageButton ID="deletedMailsImageButton" BorderWidth="0px"   ImageAlign="AbsMiddle" Width="25px" ToolTip="Recycle Bin" ImageUrl="~/App_Images/mail-trash-icon.png"  runat="server" OnClick="deletedMailsLinkButton_Click" AlternateText="Recycle Bin" /></td>
                        <td><asp:LinkButton ID="deletedMailsLinkButton" runat="server" Text="Recycle Bin" OnClick="deletedMailsLinkButton_Click"></asp:LinkButton></td>
                    </tr>

                    <tr>
                        <td><asp:ImageButton ID="addressBookImageButton" BorderWidth="0px"  ImageAlign="AbsMiddle" Width="25px" ToolTip="Address Book" ImageUrl="~/App_Images/picture-check-icon.png"  runat="server" OnClick="addressBookLinkButton_Click" AlternateText="Address Book" /></td>
                        <td><asp:LinkButton ID="addressBookLinkButton" runat="server" Text="Address Book" OnClick="addressBookLinkButton_Click"></asp:LinkButton></td>
                    </tr>
                </table>                 
            </div>
            <div style="width:840px; height:460px; border: 1px solid; border-radius: 10px; margin-left:5px; float:left; padding:5px;">

                <asp:Panel ID="inboxPanel" runat="server" Visible="false">                    
                        <asp:ImageButton ID="inbox_deleteImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" ToolTip="Delete" ImageUrl="~/App_Images/mail-delete-icon.png"  runat="server" OnClick="inbox_deleteImageButton_Click" AlternateText="Delete" />
                    <br />
                    <div style="width:840px; height: 425px; overflow-y:scroll;" >
                        <asp:GridView ID="inbox_emailsGridView" runat="server" 
                            AutoGenerateColumns="False" 
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            AllowPaging="false" 
                            SelectedRowStyle-BackColor="#CCCCFF"
                            onrowdatabound="inbox_emailsGridView_RowDataBound" 
                            onselectedindexchanged="inbox_emailsGridView_SelectedIndexChanged" 
                            Width="820px">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderStyle-CssClass ="HiddenColumn" ItemStyle-CssClass="HiddenColumn" HtmlEncode="False" />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" >
                                    <ItemTemplate>
                                        <asp:CheckBox ID="checkBoxID" runat="server"  />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" >
                                    <ItemTemplate>
                                        <asp:ImageButton ID="inboxEmailStatusImageButton" runat="server" BorderWidth="0px" ImageAlign="AbsMiddle" Width="16px" ToolTip="Email" ImageUrl='<%# ((Eval("status") != null && Eval("status").ToString().Equals(Constants.EmailMessageStatus.UnReaded.ToString())) ?  "~/App_Images/email_unreaded.png" : "~/App_Images/email_readed.png")  %>' AlternateText="Email Status" />
                                    </ItemTemplate>
                                </asp:TemplateField>                          
                                <asp:BoundField DataField="FromUser" HeaderText="From" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="toUser" HeaderText="To" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="subject" HeaderText="Subject" HeaderStyle-Width="60%" ItemStyle-Width="60%"  HtmlEncode="False" /> 
                                <asp:BoundField DataField="date" HeaderText="Date" ItemStyle-Width = "80px"  HeaderStyle-Width="80px" ItemStyle-Font-Size="X-Small" />     
                            </Columns>
                        </asp:GridView>
                    </div>                     
                </asp:Panel>

                <asp:Panel ID="readEmailPanel" runat="server" Visible="false">
                    <asp:ImageButton ID="readEmailReplayImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" ToolTip="Replay" ImageUrl="~/App_Images/mail-arrow-left-icon.png"  runat="server" OnClick="readEmailReplayImageButton_Click" AlternateText="Replay" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:ImageButton ID="readEmailForwardImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" ToolTip="Forward" ImageUrl="~/App_Images/mail-arrow-right-icon.png"  runat="server" OnClick="readEmailForwardImageButton_Click" AlternateText="Forward" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:ImageButton ID="readEmailDeleteImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" ToolTip="Delete" ImageUrl="~/App_Images/mail-delete-icon.png"  runat="server" OnClick="readEmailDeleteImageButton_Click" AlternateText="Delete" />
                <br />
                    <table style="width:100%;">
                        <tr>
                            <td style="width:60px; text-align:left;">Subject:</td>
                            <td>
                                <asp:Label ID="readEmail_subjectLabel" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="readEmailID_HiddenFiled" runat="server" />
                                <asp:HiddenField ID="lastPanelHiddenField" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width:60px; text-align:left;">From:</td>
                            <td><asp:Label ID="readEmail_FromLabel" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:60px; text-align:left;">To:</td>
                            <td><asp:Label ID="readEmail_ToLabel" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width:60px; text-align:left;">Date:</td>
                            <td><asp:Label ID="readEmail_DateLabel" runat="server" Text=""></asp:Label></td>
                        </tr>
                    </table>
     
                    <div style="width:835px; height:340px; border:none; background-color:#FAFAFA;">
                        <asp:TextBox ID="readEmail_bodyMessage" runat="server" TextMode="MultiLine" Width="835px" Height="335px" ReadOnly="true"></asp:TextBox>
                    </div>
                </asp:Panel>

                <asp:Panel runat="server" ID="composePanel" Visible="false">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100px; text-align:right;">To:</td>
                            <td>
                                <asp:DropDownList ID="composeEmailToUsersDDL" runat="server" Visible="true"  Width="400px"></asp:DropDownList>
                                <asp:TextBox ID="composeEmailTo_TextBox" runat="server" Width="400px" Visible="false"></asp:TextBox>                                
                            </td>
                        </tr>
                        <tr>
                            <td style="width:100px; text-align:right;">Subject:</td>
                            <td><asp:TextBox ID="composeEmail_Subject" runat="server"  Width="100%"></asp:TextBox></td>
                        </tr>                          
                        <tr>
                            <td style="width:100px; text-align:right;">Message Type:</td>
                            <td>
                                <div style="width:500px; float:left;">
                                     <asp:DropDownList ID="composeEmail_MessageTypeDDL" runat="server" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="composeEmail_MessageTypeDDL_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                                <div style="width:100px; float:right; text-align:right;">                              
                                    <asp:Button runat="server" Text="Send" ID="somposeMessageSendButton" OnClick="somposeMessageSendButton_Click" Width="100px" />
                                </div>                                
                            </td>
                        </tr>
                    </table>
     
                    <div style="width:835px; height:370px; border:none; background-color:#FAFAFA;">
                        <asp:TextBox runat="server" ID="composeEMail_MessageBodyTextBox"  Width="835px" Height="365px" TextMode="MultiLine" />                           
                    </div>
                </asp:Panel>

                <asp:Panel ID="sendedEmails" runat="server" Visible="false">                    
                    <div style="width:840px; height: 425px; overflow-y:scroll;" >
                        <asp:ImageButton ID="sendedEmailsDeleteImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" ToolTip="Delete" ImageUrl="~/App_Images/mail-delete-icon.png"  runat="server" OnClick="sendedEmailsDeleteImageButton_Click" AlternateText="Delete" />
                        <br />
                        <asp:GridView ID="sendedGridView" runat="server" 
                            AutoGenerateColumns="False" 
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            AllowPaging="false" 
                            SelectedRowStyle-BackColor="#CCCCFF"
                            onrowdatabound="sendedGridView_RowDataBound" 
                            onselectedindexchanged="sendedGridView_SelectedIndexChanged" 
                            Width="820px">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderStyle-CssClass ="HiddenColumn" ItemStyle-CssClass="HiddenColumn" HtmlEncode="False" />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" >
                                    <ItemTemplate>
                                        <asp:CheckBox ID="checkBoxID" runat="server"  />
                                    </ItemTemplate>
                                </asp:TemplateField>                                                 
                                <asp:BoundField DataField="FromUser" HeaderText="From" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="ToUser" HeaderText="To" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="subject" HeaderText="Subject" HeaderStyle-Width="60%" ItemStyle-Width="60%"  HtmlEncode="False" /> 
                                <asp:BoundField DataField="date" HeaderText="Date" ItemStyle-Width = "80px"  HeaderStyle-Width="80px" ItemStyle-Font-Size="X-Small" />     
                            </Columns>
                        </asp:GridView>
                    </div>                     
                </asp:Panel>

                <asp:Panel runat="server" ID="deletedEmailsPanel" Visible="false">
                    <div style="width:840px; height: 425px; overflow-y:scroll;" >
                        <asp:ImageButton ID="deletedEmailsDeleteImageButton" BorderWidth="0px" ImageAlign="Middle" Width="32px" OnClientClick="return confirm('You really want to permanently delete selected messages?');" ToolTip="Delete" ImageUrl="~/App_Images/mail-delete-icon.png"  runat="server" OnClick="deletedEmailsDeleteImageButton_Click" AlternateText="Delete" />
                        <br />
                        <asp:GridView ID="deletedEmailsGridView" runat="server" 
                            AutoGenerateColumns="False" 
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            AllowPaging="false" 
                            SelectedRowStyle-BackColor="#CCCCFF"
                            onrowdatabound="deletedEmailsGridView_RowDataBound" 
                            onselectedindexchanged="deletedEmailsGridView_SelectedIndexChanged" 
                            Width="820px">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderStyle-CssClass ="HiddenColumn" ItemStyle-CssClass="HiddenColumn" HtmlEncode="False" />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" >
                                    <ItemTemplate>
                                        <asp:CheckBox ID="checkBoxID" runat="server"  />
                                    </ItemTemplate>
                                </asp:TemplateField>                                                 
                                <asp:BoundField DataField="FromUser" HeaderText="From" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="ToUser" HeaderText="To" HeaderStyle-Width="20%" ItemStyle-Width="20%"   HtmlEncode="False" />
                                <asp:BoundField DataField="subject" HeaderText="Subject" HeaderStyle-Width="60%" ItemStyle-Width="60%"  HtmlEncode="False" /> 
                                <asp:BoundField DataField="date" HeaderText="Date" ItemStyle-Width = "80px" HeaderStyle-Width="80px" ItemStyle-Font-Size="X-Small" />     
                            </Columns>
                        </asp:GridView>
                    </div>            
                </asp:Panel>

                <asp:Panel runat="server" ID="addessBookPanel" Visible="false">
                    Address Book
                </asp:Panel>

            </div>  
        </ContentTemplate>
    </asp:UpdatePanel>

    <div style="clear:both;"></div>
  
</asp:Panel>