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
        <ajax:TabContainer ID="detailsClientTabContainer"  runat="server" cssclass="ajax__myTab"  Width="100%" ActiveTabIndex="0">  
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
                        &nbsp;<br /><asp:GridView ID="loansGridView" runat="server"                            
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

            <ajax:TabPanel ID="bankInfoTabPanel" runat="server">
                <HeaderTemplate>  Banca  </HeaderTemplate>	
                <ContentTemplate>  
                    <div class="TreeLeftColumn groupDataPanel" >
                        <fieldset>
                            <legend>DATELE BANCARE</legend>                                
                            <dl> 
                                <dt class="part">Banca Selectata: </dt>
                                <dd class="part"><asp:DropDownList ID="clientBankDDL" runat="server" AutoPostBack="true" OnSelectedIndexChanged="clientBankDDL_SelectedIndexChanged" ></asp:DropDownList></dd>
                                                                        
                                <dt class="inpart">IBAN: </dt>
                                <dd class="inpart"><asp:TextBox ID="clientBankIBANTextBox" runat="server" ReadOnly="True" CssClass="microElement"/></dd>

                                <dt class="part">Contul bancar: </dt>
                                <dd class="part"><asp:TextBox ID="clientBankContBancarTextBox" runat="server" CssClass="microElement"/></dd>
                            </dl>                             
                        </fieldset>
                    </div>    
                    <br />
                    <div class="centerBox" style="width:255px">
                            <asp:Button ID="Button3"  runat="server" Text="Save Personal Data" onclick="clientPersonalDataSaveButton_Click" Width="150px"  />
                            <asp:Button ID="Button4" runat="server" Text="Cancel"  onclick="clientPersonalDataCancelButton_Click" Width="100px"  />
                    </div>                
                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="AddressInfoTabPanel" runat="server">
                <HeaderTemplate>&nbsp;Adrese&nbsp;</HeaderTemplate>	
                <ContentTemplate>  
                         <div class="TreeCenterColumn">
                                <asp:Panel ID="adresaPanel" runat="server" GroupingText="ADRESA" CssClass="groupDataPanel">                               
                                    <asp:Label ID="Label9" runat="server" Text="Viza de resedinta"></asp:Label>
                                    <dl>         
                                        <dt class="part">Tara: </dt>
                                        <dd class="part"><asp:DropDownList ID="vizaClientAddressCountryDDL" runat="server"  AutoPostBack="True"  onselectedindexchanged="vizaClientCountryDDL_SelectedIndexChanged" CssClass="microDDL"/></dd>

                                        <dt class="inpart">Raionul: </dt>
                                        <dd class="inpart"> <asp:DropDownList ID="vizaClientAddressClientRaionDDL" runat="server" CssClass="microDDL"/></dd>

                                        <dt class="part">Urban / Rural : </dt>
                                        <dd class="part"> <asp:DropDownList ID="vizaUrbanRuralDDL" runat="server" CssClass="microDDL">
                                                <asp:ListItem Text="**"/>
                                                <asp:ListItem Text="Rural"  Value="Rural"/>
                                                <asp:ListItem Text="Urban"  Value="Urban"/>
                                            </asp:DropDownList>
                                        </dd>

                                        <dt class="inpart">Localitatea:  </dt>
                                        <dd class="inpart"><asp:TextBox ID="vizaClientAddressLocalitateaTextBox" runat="server" CssClass="microElement"/></dd>

                                        <dt class="part">Adresa/Strada:  </dt>
                                        <dd class="part"><asp:TextBox ID="vizaClientAddressAdresaTextBox" runat="server" CssClass="microElement"/></dd>
                                    </dl>

                                    <br /><br />
                                        Adresa reala de locuinta
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="copyInfoFromVizaAddress" runat="server" OnClick="copyInfoFromVizaAddress_Click" Text="Copie de la viza de resedinta" />
                                    <dl>
                                        <dt class="part">Tara:</dt>
                                        <dd class="part"><asp:DropDownList ID="rAddressClientCountryDDL" runat="server"  AutoPostBack="True"  onselectedindexchanged="rAddressClientCountryDDL_SelectedIndexChanged" CssClass="microDDL"/></dd>

                                        <dt class="inpart">Raionul: </dt>
                                        <dd class="inpart"><asp:DropDownList ID="rAddressClientRaionDDL" runat="server" CssClass="microDDL"/></dd>

                                        <dt class="part">Urban / Rural : </dt>
                                        <dd class="part"> <asp:DropDownList ID="rAddressUrbanRuralDDL" runat="server" CssClass="microDDL">
                                                <asp:ListItem Text="**"/>
                                                <asp:ListItem Text="Rural"  Value="Rural"/>
                                                <asp:ListItem Text="Urban"  Value="Urban"/>
                                            </asp:DropDownList>
                                        </dd>

                                        <dt class="inpart">Localitatea: </dt>
                                        <dd class="inpart"><asp:TextBox ID="rAddressClientLocalitateaTextBox" runat="server" CssClass="microElement"/></dd>

                                        <dt class="part">Adresa/Strada: </dt>
                                        <dd class="part"><asp:TextBox ID="rAddressAddresaStradaTextBox" runat="server" CssClass="microElement"/></dd>
                                    </dl>        
                                    
                                    <br />
                                    <div class="centerBox" style="width:255px">
                                            <asp:Button ID="Button5"  runat="server" Text="Save Personal Data" onclick="clientPersonalDataSaveButton_Click" Width="150px"  />
                                            <asp:Button ID="Button6" runat="server" Text="Cancel"  onclick="clientPersonalDataCancelButton_Click" Width="100px"  />
                                    </div>        
                                </asp:Panel>
                            </div>
                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="BussnessInformationTabPanel" runat="server">
                <HeaderTemplate>&nbsp;Descriere Afacere&nbsp;</HeaderTemplate>				    
                    <ContentTemplate>
  
                        <div class="leftColumn" style="padding:4px 4px 4px 4px; background-color: white; width:48%; ">
                            <dl> 
                                <dt class="part" style="width:200px;">Domeniu Economic: </dt>
                                <dd class="part"><asp:DropDownList ID="clientBusinessSectorAfacereDDL" runat="server" CssClass="microDDL" /></dd>

                                <dt class="impart" style="width:200px;">Tip Afacere: </dt>
                                <dd class="impart"><asp:TextBox ID="tipAfacereTextBox" runat="server"  CssClass="microElement"/></dd>

                                <dt class="part" style="height:50px; width:200px;">Descriere afacere: </dt>
                                <dd class="part" style="height:50px;"><asp:textbox runat="server" ID="clientBusinessDexcriereActivitateTextbox" TextMode="MultiLine" CssClass="microElement" Height="100%"/></dd>

                                <dt class="impart" style="width:200px;">Ani de experienta in domeniu: </dt>
                                <dd class="impart"><asp:TextBox ID="clientBusinessAniExperientaInDomeniuTextBox" runat="server"  CssClass="microElement"/></dd>

                                <dt class="part" style="width:200px;">Ani de experienta in afaceri: </dt>
                                <dd class="part"><asp:TextBox ID="clientBusinessAniExperientaInAfaceriTextBox" runat="server"  CssClass="microElement"/></dd>

                                <dt class="impart" style="width:200px;">Data inceperii afacerii: </dt>
                                <dd class="impart">
                                    <asp:TextBox ID="bussinesStartDateTextBox" runat="server"  CssClass="microElement"/>
                                    <ajax:CalendarExtender ID="bussinesStartDateCalendarExtender" runat="server"  TargetControlID="bussinesStartDateTextBox" />
                                </dd>

                                <dt class="part" style="width:200px;">Forma de activitate a afacerii: </dt>
                                <dd class="part"><asp:DropDownList ID="clientBusinessFormaInregisrAfaceriiDDL" runat="server" CssClass="microDDL" /></dd>
                            </dl>                                       
                        </div>        
                             
                        <div class="rightColumn" style="padding:4px 4px 4px 4px; background-color: white; width:48%;">     
                            <dl> 
                                <dt class="part" style="width:200px;">Suprafata teren agricol: </dt>
                                <dd class="part"><asp:TextBox ID="clientBussinesSuprafataTerenAgricolTextBox" runat="server"  CssClass="microElement"></asp:TextBox></dd>

                                <dt class="impart" style="width:200px;">Cladiri Comerciale: </dt>
                                <dd class="impart"><asp:TextBox ID="clientBussinesCladiriComTextBox" runat="server"  CssClass="microElement"/></dd>
                                
                                <dt class="part" style="width:200px;">Animale: </dt>
                                <dd class="part"><asp:TextBox ID="clientBussinesAnimaleTextBox" runat="server"  CssClass="microElement"></asp:TextBox></dd>

                                <dt class="impart" style="width:200px;">Vehicole Comerciale: </dt>
                                <dd class="impart"><asp:TextBox ID="clientBussinesvehicoleComercialeTextBox" runat="server"  CssClass="microElement"/></dd>

                                <dt class="part" style="width:200px;">Nr. angajati:</dt>
                                <dd class="part"><asp:TextBox ID="clientBussinesNrAngajatiTextBox" runat="server"  CssClass="microElement"></asp:TextBox></dd>

                                <dt class="impart" style="width:200px;">Datorii:</dt>
                                <dd class="impart"><asp:TextBox ID="clientBussinesDatoriiTextBox" runat="server"  CssClass="microElement"></asp:TextBox></dd>
                            </dl>                                   
                        </div>

                            <div class="clear"></div>

                            <div class="centerBox" style="width:220px">
                                <asp:Button ID="clientBusinessSaveButton"  runat="server" Text="Save" Width="100px" onclick="clientBusinessSaveButton_Click"   />
                                <asp:Button ID="clientBusinessCancelButton" runat="server" Text="Cancel" Width="100px"  onclick="clientBusinessCancelButton_Click"  />
                            </div>
                    </ContentTemplate>			    
                </ajax:TabPanel>   

            <ajax:TabPanel ID="personalTrainingsTabPanel" runat="server">
                        <HeaderTemplate>&nbsp;Instruire&nbsp;</HeaderTemplate>  
                            <ContentTemplate>
                           
                                    <div class="leftColumn">
                                        <asp:GridView ID="personalTrainigsGridView" runat="server"                            
                                            AutoGenerateColumns="False" 
                                            CssClass="mGrid"
                                            AllowPaging="True"         
                                            PageSize="3"
                                            OnRowDeleting="personalTrainigsGridView_Deleting"
                                            onpageindexchanging="personalTrainigsGridView_PageIndexChanging" 
                                            onselectedindexchanging="personalTrainigsGridView_SelectedIndexChanging" 
                                            onrowdatabound="personalTrainigsGridView_RowDataBound">
                                            <AlternatingRowStyle CssClass="alt" />
                                            <Columns>
                                                <asp:BoundField DataField="trainingID" HeaderText="trainingID"  HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass="HiddenColumn" HtmlEncode="False" />                                

                                                <asp:BoundField DataField="TrainingName" HeaderText="Denumirea Instruirii" HtmlEncode="true" />

                                                <asp:TemplateField HeaderText="Training Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="trainingDateLabel" runat="server" Text='<%# ((Eval("trainingDate") != null && Eval("trainingDate") is DateTime) ?  ((DateTime)Eval("trainingDate")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>    
                                        
                                                <asp:BoundField DataField="tipulInstruirii" HeaderText="Tipul Instruirii" HtmlEncode="true" />
                                        
                                                <asp:BoundField DataField="trainingScop" HeaderText="trainingScop" HtmlEncode="true" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass="HiddenColumn" />
                                                <asp:BoundField DataField="DescrirereaInstruirii" HeaderText="DescrirereaInstruirii" HtmlEncode="true" HeaderStyle-CssClass="HiddenColumn" ItemStyle-CssClass="HiddenColumn" />

                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Sunteti sigur?');" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                               
                                            </Columns>
                                            <PagerStyle CssClass="pgr" />
                                            <SelectedRowStyle BackColor="#CCCCFF" />
                                        </asp:GridView>
                                    </div>

                                    <div class="rightColumn"  style="text-align:center"> 
                                        <asp:Label runat="server" ID="infoLabel" Text="DETALII CURS DE INSTRUIRE" 
                                            Font-Bold="True" Font-Italic="False" Font-Size="Large" ></asp:Label>    
                                        <table>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label1" Text="Data:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="dataLabel" Text="" /></td>
                                            </tr>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label2" Text="Operator:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="operatorLabel" Text="" /></td>
                                            </tr>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label3" Text="Tip instruire:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="tipInstruireLabel" Text="" /></td>
                                            </tr>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label4" Text="Denumirea:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="denumireaLabel" Text="" /></td>
                                            </tr>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label5" Text="Scop:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="scopLabel" Text="" /></td>
                                            </tr>
                                            <tr>
                                                <td class="infoTableLeft"><asp:Label runat="server" ID="Label6" Text="Descriere:" /></td>
                                                <td class="infoTableRigth"><asp:Label runat="server" ID="descriereLabel" Text="" /></td>
                                            </tr>
                                        </table>    
                                    </div>
                                    <div class="clear"></div>
                                    <div class="centerBox">                            
                                        <asp:Button ID="addPersonalTrainiButton" runat="server" Text="Add new Training" onclick="addPersonalTrainiButton_Click" />
                               
                                        <asp:Panel ID="addPersonalTrainingPanel" runat="server" Visible="false">
                                            <asp:DropDownList ID="addPersonalTrainingListDDL" runat="server" Width="400px"> </asp:DropDownList>
                                            <asp:Button ID="addPersonalTrainingSaveButton" runat="server" Text="Save" onclick="addPersonalTrainingSaveButton_Click" />
                                        </asp:Panel>  
                                    </div>
                            </ContentTemplate>
                    </ajax:TabPanel>

            <ajax:TabPanel ID="consultingTabPanel" runat="server">
                        <HeaderTemplate> Consultari / Evaluari </HeaderTemplate> 				    
                        <ContentTemplate>                      
                            <div style="float:left; width:30%;" >
                                <asp:Panel ID="Panel2" runat="server" GroupingText="Editarea unei Evaluari/Consultari" CssClass="groupDataPanel">
                                        <dl> 
                                        <dt class="part" style="width:170px;">Data: </dt>
                                        <dd class="part">
                                            <asp:TextBox ID="editDataTextBox" runat="server" CssClass="microElement"></asp:TextBox>
                                            <ajax:CalendarExtender ID="editDataCalendarExtender" runat="server"  TargetControlID="editDataTextBox" Enabled="True"/>
                                        </dd>

                                        <dt class="impart" style="width:170px;">Operator: </dt>
                                        <dd class="impart"><asp:DropDownList ID="consultEvalOperDDL" runat="server" CssClass="microDDL" /> </dd>

                                        <dt class="part" style="width:170px;">Tip consultare/evaluare: </dt>
                                        <dd class="part"><asp:DropDownList ID="tipConsultEvalDDL" runat="server"  CssClass="microDDL"/>  </dd>

                                        <dt class="impart" style="width:170px; height:50px;">Scopul: </dt>
                                        <dd class="impart" style="height:70px;"><asp:TextBox ID="editConsultDescriptionTextBox" runat="server" Height="70px"  Width="100%" TextMode="MultiLine" CssClass="microElement"></asp:TextBox></dd>

                                    </dl>
                                </asp:Panel>

                                <asp:Panel ID="Panel3" runat="server" GroupingText="Parametrii de evaluare" CssClass="groupDataPanel">
                                    <dl> 
                                        <dt class="part" style="width:170px;">Starea afaracerii: </dt>
                                        <dd class="part"> <asp:DropDownList ID="consultEvalBussnesStateDDL" runat="server" CssClass="microDDL" />  </dd>

                                        <dt class="impart" style="width:170px;">Nr. de angajati: </dt>
                                        <dd class="impart"><asp:TextBox ID="editNrEmplTextBox" runat="server" CssClass="microElement"></asp:TextBox></dd>

                                        <dt class="part" style="width:170px;">Venit mediu lunar:</dt>
                                        <dd class="part"> <asp:TextBox ID="editAverajeMonthlyIncomeTextBox" runat="server" CssClass="microElement"></asp:TextBox>  </dd>

                                        <dt class="impart" style="width:170px; height:50px;">Scurta descriere a situatiei la zi (eventual cauza falimentului): </dt>
                                        <dd class="impart" style="height:70px;"><asp:TextBox ID="editShortDescriptionStateTextBox" runat="server" Height="70px"  Width="100%" TextMode="MultiLine" CssClass="microElement"></asp:TextBox></dd>

                                    </dl>
                                </asp:Panel>
                            </div>
                            <div style="float:right; width:70%;">
                                <asp:Button ID="addNewConsultEvalButton" runat="server" Text="Adaugarea unei noi Consultari / Evaluari" onclick="addNewConsultEvalButton_Click" />
                                <asp:GridView ID="consultEvalGridView" runat="server"                            
                                    AutoGenerateColumns="False" 
                                    CssClass="mGrid"
                                    AllowPaging="True"         
                                    onselectedindexchanged="consultEvalGridView_SelectedIndexChanged" 
                                    onrowdatabound="consultEvalGridView_RowDataBound" 
                                    onrowdeleting="consultEvalGridView_RowDeleting">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>     
                                        <asp:BoundField DataField="clevid" HeaderText="clevid" HtmlEncode="False" >                       
                                            <HeaderStyle CssClass="HiddenColumn" />
                                            <ItemStyle CssClass="HiddenColumn" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Data">
                                            <ItemTemplate>
                                                <asp:Label ID="consultDataLabel" runat="server" Text='<%# ((Eval("data") != null && Eval("data") is DateTime) ?  ((DateTime)Eval("data")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>    

                                        <asp:BoundField DataField="Operator Full Name" HeaderText="Operator"  HtmlEncode="False" />                                
                                        <asp:BoundField DataField="TipConsultEval_string" HeaderText="Tip Consultare" HtmlEncode="False" />                                        
                                        <asp:BoundField DataField="BusinessState_string" HeaderText="Starea Afacerii" HtmlEncode="False" />   
                                        <asp:BoundField DataField="fotocount" HeaderText="Fotografii anexate" HtmlEncode="False" />  
                                        <asp:TemplateField HeaderText="Delete">
                                            <ItemTemplate>
                                                    <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Sunteti sigur ca vreti sa stergeti?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>                                                           
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <SelectedRowStyle BackColor="#CCCCFF" />
                                </asp:GridView>

                                <br />

                                <asp:FileUpload ID="editConsultFileUpload" AllowMultiple="True" runat="server"  />   
                                <asp:Button ID="editFileUploadButton" runat="server" Text="Upload" onclick="editFileUploadButton_Click" />
                                    <br />                            
                                <div id="editConsultPfotoContainer" runat="server"> </div>
                            </div>
                   
                            <div class="clear"></div>

                            <div class="centerBox" style="width:150px">
                                <asp:Button ID="editConsultSaveButton"  runat="server" Text="Save" onclick="editConsultSaveButton_Click"   />
                                <asp:Button ID="editConsultCancelButton" runat="server" Text="Cancel"  onclick="editConsultCancelButton_Click"  />
                            </div>  
                        </ContentTemplate> 		        
                    </ajax:TabPanel>

        </ajax:TabContainer>          

         <fb:FileBrowser ID="personalFileBrowser" runat="server" />   
         <csd:ClientSelectionControl ID="husbandClientSelectionControl" runat="server" TitleWindow="Lista Contragentilor Inregistrati" ParameterX="200" ParameterY="200" OnOnClientSelected="husbandClientSelectionControl_OnClientSelected" />
  
    </asp:Panel>

</asp:Content>

