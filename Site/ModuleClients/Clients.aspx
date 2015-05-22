<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Clients.aspx.cs" Inherits="Clients"  EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register TagPrefix="fb" TagName="FileBrowser" Src="~/Controls/NFileBrowser.ascx" %>
<%@ Register TagPrefix="csd" TagName="ClientSelectionControl" Src="~/Controls/ClientSelectionControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script type="text/javascript" src="../scripts/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../scripts/jquery.colorbox.js"></script>
    <script type="text/javascript" src="../scripts/jquery.helper.js"></script>
    <link href="../CSS/jquery.dataTables.css" rel="stylesheet" />

    <script type="text/javascript" language="javascript" class="init">    

        $(document).ready(function () {
            $('#<%=clientListGridView.ClientID%>').dataTable();

            //Examples of how to assign the ColorBox event to elements
            $(".group1").colorbox({ rel: 'group1' });
            $(".group2").colorbox({ rel: 'group2', transition: "fade" });
            $(".group3").colorbox({ rel: 'group3', transition: "none", width: "75%", height: "75%" });
            $(".group4").colorbox({ rel: 'group4', slideshow: true });
            $(".ajax").colorbox();
            $(".youtube").colorbox({ iframe: true, innerWidth: 425, innerHeight: 344 });
            $(".iframe").colorbox({ iframe: true, width: "80%", height: "80%" });
            $(".inline").colorbox({ inline: true, width: "50%" });
            $(".callbacks").colorbox({
                onOpen: function () { alert('onOpen: colorbox is about to open'); },
                onLoad: function () { alert('onLoad: colorbox has started to load the targeted content'); },
                onComplete: function () { alert('onComplete: colorbox has displayed the loaded content'); },
                onCleanup: function () { alert('onCleanup: colorbox has begun the close process'); },
                onClosed: function () { alert('onClosed: colorbox has completely closed'); }
            });

            //Example of preserving a JavaScript event for inline calls.
            $("#click").click(function () {
                $('#click').css({ "background-color": "#f00", "color": "#fff", "cursor": "inherit" }).text("Open this window again and this message will still be here.");
                return false;
            });
        });

        function checkFileExtension(elem) {
            var filePath = elem.value;

            if (filePath.indexOf('.') == -1)
                return false;

            var validExtensions = new Array();
            var ext = filePath.substring(filePath.lastIndexOf('.') + 1).toLowerCase();

            validExtensions[0] = 'jpg';
            validExtensions[1] = 'jpeg';

            for (var i = 0; i < validExtensions.length; i++) {
                if (ext == validExtensions[i]) {
                    return true;
                }
            }

            alert('The file extension ' + ext.toUpperCase() + ' is not allowed!');
            return false;
        }

    </script>
    	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <asp:Panel ID="clientSelectionPanel" runat="server" Visible="false">
        <div style="text-align:right;">
            <asp:Button ID="addNewClientButton" runat="server" Text="Add New Client" OnClick="addNewClientButton_Click" />
        </div>
        <asp:GridView ID="clientListGridView" runat="server" 
                AutoGenerateColumns="False" 
                CssClass="display"   
                UseAccessibleHeader="true"
                          
                onrowdatabound="clientListGridView_RowDataBound" 
                onselectedindexchanged="clientListGridView_SelectedIndexChanged" 
                Width="100%" OnPreRender="clientListGridView_PreRender" >
                <Columns>
                    <asp:BoundField DataField="clientID" ItemStyle-CssClass="HiddenColumn" HeaderStyle-CssClass="HiddenColumn" />
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName"  />
                
                    <asp:TemplateField HeaderText="Data Nastere">
                        <ItemTemplate>
                            <asp:Label ID="dateOfBirthLabel" Width="100px" runat="server" Text='<%# ((Eval("DateOfBirth") != null && Eval("DateOfBirth") is DateTime) ?  ((DateTime)Eval("DateOfBirth")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="SortGroup_string" HeaderText="Categoria"/>
                    <asp:BoundField DataField="buletinSeria" HeaderText="Buletin"  />
                    <asp:BoundField DataField="personalID" HeaderText="Personal ID"  /> 
                    <asp:BoundField DataField="telefon" HeaderText="Telefon"  />                                                  
                </Columns>
            </asp:GridView>
    </asp:Panel>


    <asp:Button runat="server" ID="hiddenTargetControlnewClientModalPopup" Style="display: none" />
    <ajax:ModalPopupExtender 
        runat="server" 
        ID="newClientModalPopup" 
        TargetControlID="hiddenTargetControlnewClientModalPopup" 
        PopupControlID="newClientPanel"
        PopupDragHandleControlID="newClientPanel"
        DropShadow="True" 
        CancelControlID="newClientCancelButton"
        RepositionMode="RepositionOnWindowScroll">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="newClientPanel" runat="server" GroupingText="DATELE DE BAZA A CLIENTULUI" CssClass="groupDataPanel" Width="350px" style="display:none;" > 
        Foto Clientului:
        <div class="centerBox" style="width:240px; height:240px"> 
            <asp:Image ID="newClientImage" runat="server" />  </div>
            <asp:HiddenField ID="newClientImageHiddenField" runat="server" />
        <br /> 
        <asp:FileUpload ID="newClientFotoFileUpload" runat="server" Width="180px" />
        <asp:Button ID="newClientFotoUploadButton" runat="server" Text="Upload" onclick="newClientFotoUploadButton_Click" Width="56px" />

        <dl>         
            <dt class="part"><asp:Label ID="Label7" runat="server" Text="Numele:"></asp:Label></dt>
            <dd class="part"><asp:TextBox ID="newClientNumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

            <dt class="inpart" runat="server" id="Dt1">Prenumele: </dt>
            <dd class="inpart" runat="server" id="Dd1"><asp:TextBox ID="newClientPrenumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

            <dt class="part"><asp:Label runat="server" ID="Label8" Text="Data Nasterii:"></asp:Label></dt>
            <dd class="part">
                <asp:TextBox ID="newClientBirthDateTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                <ajax:CalendarExtender ID="newClientBirthDateCalendarExtender" runat="server"  TargetControlID="newClientBirthDateTextBox" />
            </dd>           
              
            <dt class="part">Telefon Fix:</dt>
            <dd class="part"><asp:TextBox ID="newClientTelefonFixTextBox" runat="server" MaxLength="50" CssClass="microElement"></asp:TextBox></dd>
            
            <dt class="inpart">Telefon mobil:</dt>
            <dd class="inpart"><asp:TextBox ID="newClientTelefonMobilTextBox" runat="server" MaxLength="50" CssClass="microElement"/></dd>
 
            <dt class="part">Telefon mobil 2:</dt>
            <dd class="part"><asp:TextBox ID="newClientTelefonMobil2TextBox" runat="server" MaxLength="50" CssClass="microElement"/></dd>

            <dt class="inpart">Email:</dt>
            <dd class="inpart"><asp:TextBox ID="newClientEmailTextBox" runat="server" CssClass="microElement"/></dd>

            <dt class="part">Categoria pentru Filtru:</dt>
            <dd class="part"><asp:DropDownList ID="newClientCategoryDDL" runat="server" CssClass="microDDL"></asp:DropDownList></dd>

        </dl>
        
        <div style="text-align:right;">
            <asp:Button ID="newClientSaveButton" runat="server" Text="Salvare" Width="100px" OnClick="newClientSaveButton_Click" />
            <asp:Button ID="newClientCancelButton" runat="server" Text="Inchide" Width="100px"  />
        </div>
    </asp:Panel>




    <asp:Panel ID="clientWorkPanel" Visible="false" runat="server">
        <ajax:TabContainer ID="detailsClientTabContainer"  runat="server" cssclass="ajax__myTab"  Width="100%" ActiveTabIndex="5">  
            <ajax:TabPanel ID="generalInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Generalizari&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <div style="float:left; width:20%;">                        
                        Foto Clientului:
                        <div class="centerBox" style="width:240px; height:240px"> 
                            <asp:Image ID="generalInfoImage" runat="server"  />  </div>
                        <table>
                            <tr>
                                <td>Activation date:</td>
                                <td><asp:Label ID="genInfoActivationDateLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Nr. de lefenon:</td>
                                <td><asp:Label ID="genInfoMobileNumberLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Manager creditare:</td>
                                <td><asp:Label ID="genInfoManagerCreditareLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2">Performance History:</td>
                            </tr>
                            <tr>
                                <td> Nr. de Imprumuturi:</td>
                                <td><asp:Label ID="genInfoTotalLoansNumberLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Summa ultimul imprumut:</td>
                                <td> <asp:Label ID="genInfoLastLoanAmountLabel" runat="server"></asp:Label>   </td>
                            </tr>
                            <tr>
                                <td>Imprumuturi active:</td>
                                <td><asp:Label ID="genInfoActiveLoansLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Total savings:</td>
                                <td><asp:Label ID="genInfoTotalSavingsLabel" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Active savings:</td>
                                <td><asp:Label ID="genInfoActiveSavingsLabel" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                                                         
                    </div>
                    <div style="width:80%;float:left;">
                        <asp:HiddenField ID="activInactivloansHiddenField" runat="server" Value="Active" />
                        <asp:Button ID="activeInactiveCreditsButton" runat="server" Text="Credite Inchise"  Width="150px"  onclick="activeInactiveCreditsButton_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="refreshLoansButton" runat="server" Text="Refresh"  Width="150px"  onclick="refreshLoansButton_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" id="addNewCreditButton" Text="+ Credit" style="width:150px;" OnClick="addNewCreditButton_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Text="Personal Folder" Width="150px" ID="clientPersonalFolderButton" OnClick="clientPersonalFolderButton_Click"></asp:Button>
                        &nbsp;<br />
                        
                        <asp:GridView ID="loansGridView" runat="server"                            
                            AutoGenerateColumns="False" 
                            CssClass="mGrid"
                            AllowPaging="True"         
                            PageSize="3"
                            onpageindexchanging="loansGridView_PageIndexChanging" 
                            onselectedindexchanged="loansGridView_SelectedIndexChanged" 
                            onrowdatabound="loansGridView_RowDataBound">
                            <AlternatingRowStyle CssClass="alt" />
                            <Columns>
                                <asp:BoundField DataField="loanID" HeaderText="loanID" HtmlEncode="False" >                                
                                <HeaderStyle CssClass="HiddenColumn" />
                                <ItemStyle CssClass="HiddenColumn" />
                                </asp:BoundField>
                                <asp:BoundField DataField="creditAmountValue" HeaderText="Suma Credit" HtmlEncode="False" />

                                <asp:TemplateField HeaderText="Credit Start Date">
                                    <ItemTemplate>
                                        <asp:Label ID="allocationOfMoneyDateLabel" runat="server" Text='<%# ((Eval("loanStartDate") != null && Eval("loanStartDate") is DateTime) ?  ((DateTime)Eval("loanStartDate")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>    
                                        
                                <asp:BoundField DataField="nrOfCreditMonthValue" HeaderText="Perioada Imprumut (luni)" HtmlEncode="False" />
                                <asp:BoundField DataField="percentValue" HeaderText="Procent Anual" HtmlEncode="False" />
                                <asp:BoundField DataField="loanScope" HeaderText="Scopul Imprumutului" HtmlEncode="False" />
                                                                  
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <SelectedRowStyle BackColor="#CCCCFF" />
                        </asp:GridView>
                    </div>

                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="personalDataInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Date personale&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <div class="leftColumn" style="padding:4px 4px 4px 4px; background-color: white; width:48%; ">
                        <asp:Panel ID="maintainEmployeesPanel" runat="server" CssClass="groupDataPanel" GroupingText="DATELE DE BAZA A CLIENTULUI" Width="100%">   
                            Foto Clientului:
                            <div class="centerBox" style="width:240px; height:240px"> 
                                <asp:Image ID="clientImage" runat="server"  />  </div>
                            <br /> 
                            <asp:FileUpload ID="personalPhotoFileUpload" runat="server"  Width="180px" />
                            <asp:Button ID="personalPhotoUploadButton" runat="server" onclick="personalPhotoUploadButton_Click" Text="Upload" Width="56px" />

                            <dl>         
                                <dt class="part"><asp:Label ID="numeleLabel" runat="server" Text="Numele:"></asp:Label></dt>
                                <dd class="part"><asp:TextBox ID="clientNumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

                                <dt id="prenumeleDT" runat="server" class="inpart">Prenumele: </dt>
                                <dd id="prenumeleDD" runat="server" class="inpart"><asp:TextBox ID="clientPrenumeTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

                                <dt class="part"><asp:Label ID="dataNastereLabel" runat="server" Text="Data Nasterii:"></asp:Label></dt>
                                <dd class="part">
                                    <asp:TextBox ID="clientDateOfBirthTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                                    <ajax:CalendarExtender ID="clientDateOfBirthCalendarExtender" runat="server" TargetControlID="clientDateOfBirthTextBox" Enabled="True" />
                                </dd>
                
                                <dt id="plaseOfBirthDT" runat="server" class="inpart">Locul Nasterii: </dt>
                                <dd id="plaseOfBirthDD" runat="server" class="inpart">
                                    <asp:TextBox ID="clientPlaseOfBirthTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                                </dd>
   
                                <dt class="part">Telefon Fix:</dt>
                                <dd class="part"><asp:TextBox ID="addNewClientTelefonFixTextBox" runat="server" CssClass="microElement" MaxLength="50"></asp:TextBox></dd>
            
                                <dt class="inpart">Telefon mobil:</dt>
                                <dd class="inpart"><asp:TextBox ID="addNewClientTelefonMobilTextBox" runat="server" CssClass="microElement" MaxLength="50" /></dd>
 
                                <dt class="part">Telefon mobil 2:</dt>
                                <dd class="part"><asp:TextBox ID="addNewClientTelefonMobil2TextBox" runat="server" CssClass="microElement" MaxLength="50" /></dd>

                                <dt class="inpart">Email:</dt>
                                <dd class="inpart"><asp:TextBox ID="addNewClientEmailTextBox" runat="server" CssClass="microElement" /></dd>

                                <dt class="part">Categoria pentru Filtru:</dt>
                                <dd class="part"><asp:DropDownList ID="clientCategoryForFilterDDL" runat="server" CssClass="microDDL"> </asp:DropDownList></dd>
                            </dl>                           
                        </asp:Panel>
                    </div>

                    <div class="leftColumn" style="padding:4px 4px 4px 4px; background-color: white; width:48%; ">
                        <asp:Panel ID="datePersonalePanel" runat="server" CssClass="groupDataPanel" GroupingText="DATELE PERSONALE" Width="100%"> 
                        <dl>         
                            <dt class="part" style="width:30%;"><asp:Label ID="personalNumebrLabel" runat="server" Text="Cod Personal:"></asp:Label> </dt>
                            <dd class="part"><asp:TextBox ID="clientPersonalIDTextBox" runat="server" CssClass="microElement" /></dd>
                                                            

                            <dt class="inpart" style="width:30%;"><asp:Label ID="buletinSeriaLabel" runat="server" Text="Buletin Seria:"></asp:Label></dt>
                            <dd class="inpart"><asp:TextBox ID="buletinSeriaTextBox" runat="server" CssClass="microElement" /></dd>

                            <dt class="part" style="width:30%;">Eliberat De: </dt>
                            <dd class="part"><asp:TextBox ID="eliberatDeTextBox" runat="server" CssClass="microElement" /></dd>

                            <dt class="inpart" style="width:30%;">Data Eliberarii: </dt>
                            <dd class="inpart">
                                <asp:TextBox ID="dataEliberariiTextBox" runat="server" CssClass="microElement" />
                                <ajax:CalendarExtender ID="dataEliberariiCalendarExtender" runat="server" Enabled="True" TargetControlID="dataEliberariiTextBox" />
                            </dd>

                            <dt class="part" style="width:30%;">Data Expirarii: </dt>
                            <dd class="part">
                                <asp:TextBox ID="dataExpirariiTextBox" runat="server" CssClass="microElement" />
                                <ajax:CalendarExtender ID="dataExpirariiCalendarExtender" runat="server" Enabled="True" TargetControlID="dataExpirariiTextBox" />
                            </dd>                               
                                
                            <dt class="inpart" style="width:30%;"> Gen:  </dt>
                            <dd class="inpart"><asp:DropDownList ID="clientGenderDDL" runat="server" AutoPostBack="True" CssClass="microDDL" OnSelectedIndexChanged="clientGenderDDL_SelectedIndexChanged" /></dd>


                            <dt id="civilStatusDt" runat="server" class="part" style="width:30%;">Starea Civila: </dt>
                            <dd id="civilStatusDD" runat="server" class="part"><asp:DropDownList ID="clientCivilStatusDDL" runat="server" CssClass="microDDL" /></dd>

                            <dt class="inpart" style="width:30%;"> 
                                <asp:Label ID="husbendLabel" runat="server" Text="Sotia/Sotul:"></asp:Label> 
                                <asp:HiddenField ID="husbandIDHiddenField" runat="server" />  
                            </dt>
                            <dd class="inpart">
                                <div style="float:left; width:85%">
                                    <asp:TextBox ID="husbandDescriptionTextbox" runat="server" CssClass="microElement" />
                                </div>
                                <div style="float:left; width:15%; text-align: right;"><asp:Button ID="husbendShowButton" runat="server" Height="18px" OnClick="husbendShowButton_Click" style=" padding:0px; margin:0px;" Text="+" Width="18px" /></div>                                                                        
                            </dd>

                            <dt id="childrenDt" runat="server" class="part" style="width:30%;">Copii: </dt>
                            <dd id="childrenDD" runat="server" class="part"><asp:TextBox ID="personalDataClientCildrensTextBox" runat="server" CssClass="microElement" /></dd>


                            <dt class="inpart" style="width:30%;">Nr.Pers intretinere:</dt>
                            <dd class="inpart"><asp:TextBox ID="nrPersoaneInIntretinereTextbox" runat="server" CssClass="microElement" /></dd>


                            <dt class="part" style="width:30%;">Studii:</dt>
                            <dd class="part"><asp:DropDownList ID="clientEducationLevelDDL" runat="server" CssClass="microDDL" /></dd>


                            <dt class="inpart" style="width:30%;">Ocupatia curenta:</dt>
                            <dd class="inpart"><asp:DropDownList ID="clientSocialStatusDDL" runat="server" CssClass="microDDL" /></dd>


                            <dt class="part" style="width:30%;">Venit familiei lunar: </dt>
                            <dd class="part"><asp:TextBox ID="personalDataClientVenitLunarInceputTextBox" runat="server" CssClass="microElement" /></dd>


                            <dt class="inpart" style="width:30%;">Situatia materiala: </dt>
                            <dd class="inpart"><asp:DropDownList ID="situatiaMaterialaDDL" runat="server" CssClass="microDDL" /></dd>


                            <dt class="part" style="width:30%;">Biserica: </dt>
                            <dd class="part"><asp:DropDownList ID="clientChurchDDL" runat="server" CssClass="microDDL" /></dd>


                            <dt class="inpart" style="width:30%;">Slujirea in biserica: </dt>
                            <dd class="inpart"><asp:TextBox ID="slujireaInBisericaTextBox" runat="server" CssClass="microElement" /></dd>


                            <dt class="part" style="width:30%;">Pastor / Lider: </dt>
                            <dd class="part"><asp:TextBox ID="pastorLiderTextBox" runat="server" CssClass="microElement" /></dd>


                            <dt class="inpart" style="width:30%;"> Telefon pastor: </dt>
                            <dd class="inpart"><asp:TextBox ID="telefonPastorTextBox" runat="server" CssClass="microElement" /></dd>

                        </dl>
                    </asp:Panel>    
                    </div>     
                    <div class="clear"></div>
                    <div class="centerBox" style="width:255px">
                        <asp:Button ID="clientPersonalDataSaveButton"  runat="server" Text="Save Personal Data" onclick="clientPersonalDataSaveButton_Click" Width="150px"  />
                        <asp:Button ID="clientPersonalDataCancelButton" runat="server" Text="Cancel"  onclick="clientPersonalDataCancelButton_Click" Width="100px"  />
                    </div>
                </ContentTemplate>                
            </ajax:TabPanel>

      

           
  
        </ajax:TabContainer>          

     
    </asp:Panel>

</asp:Content>

