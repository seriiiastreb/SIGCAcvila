<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Customers.aspx.cs" Inherits="Customers" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server"> 
    
    <asp:Panel ID="clientSelectionPanel" runat="server" Visible="false">
        <div style="text-align:right;">
            <asp:Button ID="addNewClientButton" runat="server" Text="Add New Client" OnClick="addNewClientButton_Click" />
        </div>
        <asp:GridView ID="clientListGridView" runat="server" 
                AutoGenerateColumns="false"
                AlternatingRowStyle-CssClass="odd"
                OnRowCreated="usersGrid_RowCreated"
                OnSelectedIndexChanged="clientListGridView_SelectedIndexChanged"
                AllowPaging="false"  
                SelectedRowStyle-CssClass = "selectedRow" >
                <Columns>
                    <asp:BoundField DataField="clientID" ItemStyle-CssClass="HiddenColumn" HeaderStyle-CssClass="HiddenColumn" />
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName"  />                
                    <asp:TemplateField HeaderText="Data Nastere">
                        <ItemTemplate>
                            <asp:Label ID="dateOfBirthLabel" Width="100px" runat="server" Text='<%# ((Eval("DateOfBirth") != null && Eval("DateOfBirth") is DateTime) ?  ((DateTime)Eval("DateOfBirth")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:BoundField DataField="buletinSeria" HeaderText="Buletin"  />
                    <asp:BoundField DataField="personalID" HeaderText="Personal ID"  /> 
                    <asp:BoundField DataField="telefon" HeaderText="Telefon"  />                                                  
                </Columns>
            </asp:GridView>
    </asp:Panel>

    <asp:HyperLink ID="newClientHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

    <ajax:ModalPopupExtender ID="newClientPopupExtender" runat="server"     
        TargetControlID="newClientHyperLink"
        PopupControlID = "newClientPanel" 
        PopupDragHandleControlID="newClientHeader"
        CancelControlID="users_CancelButton"
        DropShadow="true" >
    </ajax:ModalPopupExtender>   

    <asp:Panel runat="server" ID="newClientPanel" CssClass="grid_5 box" style=" width: auto; border:1px solid #000;">
        <h2 style="cursor:move;" runat="server" id="newClientHeader">New Client  <asp:Image ID="users_CancelButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="19px" Height="19px" style="float:right; cursor:default;" /></h2>
        <fieldset>	
            <p>
                <label>Gender:</label>
                <asp:DropDownList ID="newClientGenderListDDL" runat="server" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="newClientGenderList_SelectedIndexChanged"></asp:DropDownList>
            </p>
                    
            <asp:Panel ID="newCleint_simplePersonPanel" runat="server" Visible="false">
                <p>
                    <label>Firts Name:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_FirstNameTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Last Name:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_LastNameTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Birth Date:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_BirthDateTextBox" ></asp:TextBox>
                    <ajax:CalendarExtender ID="newClientSimple_BirthDateCalendarExtender" runat="server" TargetControlID="newClientSimple_BirthDateTextBox"></ajax:CalendarExtender>
                </p>

                <p>
                    <label>Personal number (IDNP):</label>
                    <asp:TextBox runat="server" ID="newClientSimple_IDNPTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Buletin:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_BuletinTextBox" ></asp:TextBox>
                </p>

                <p>
                    <label>Telefon / Fax:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_TelefonFixTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Telefon mobil:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_TelefonMobilTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Email:</label>
                    <asp:TextBox runat="server" ID="newClientSimple_EmailTextBox" ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ErrorMessage="Wrong email!" ControlToValidate="newClientSimple_EmailTextBox" 
                        Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <ajax:ValidatorCalloutExtender 
                        runat="Server"
                        ID="PNReqE"                     
                        TargetControlID="RegularExpressionValidator1" 
                        Width="250px"
                        PopupPosition="Right" />
                </p>
            </asp:Panel>

                <asp:Panel ID="newCleint_juridPersonPanel" runat="server" Visible="true">
                <p>
                    <label>Full Name:</label>
                    <asp:TextBox runat="server" ID="newClient_juridFullNameTextBox" ></asp:TextBox>
                </p>    
                <p>
                    <label>Registration nr.:</label>
                    <asp:TextBox runat="server" ID="newClient_juridRegistrationNRTextBox" ></asp:TextBox>
                </p>                 
                <p>
                    <label>Contact Person:</label>
                    <asp:TextBox runat="server" ID="newClient_juridContactPersonTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Telefon / Fax:</label>
                    <asp:TextBox runat="server" ID="newClient_juridTelefonFixTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Telefon mobil:</label>
                    <asp:TextBox runat="server" ID="newClient_juridTelefonMobilTextBox" ></asp:TextBox>
                </p>
                <p>
                    <label>Email:</label>
                    <asp:TextBox runat="server" ID="newClient_juridEmailTextBox" ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ErrorMessage="Wrong email!" ControlToValidate="newClient_juridEmailTextBox" 
                        Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <ajax:ValidatorCalloutExtender 
                        runat="Server"
                        ID="ValidatorCalloutExtender1"                     
                        TargetControlID="RegularExpressionValidator2" 
                        Width="250px"
                        PopupPosition="Right" />
                </p>
            </asp:Panel>

            <div style="text-align:right;">
                <asp:Button runat="server" ID="newClientSaveBurtton" Text="Save" onclick="newClientSaveBurtton_Click"  Width="100px"  />
            </div>
        </fieldset>
    </asp:Panel>
    

    <asp:Panel ID="clientWorkPanel" Visible="false" runat="server">
        <ajax:TabContainer ID="detailsClientTabContainer"  runat="server" 
            cssclass="ajax__myTab"  Width="100%" ActiveTabIndex="1" Height="24px">  
            <ajax:TabPanel ID="generalInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; General Info&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <div style="float:left; width:20%;"> 
                        <table>
                            <tr>
                                <td>Activation date:</td>
                                <td><asp:Label ID="genInfoActivationDateLabel" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="personalDataTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Personal data&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <asp:Panel runat="server" ID="Panel3" CssClass="grid_5 box" style="border:1px solid #000;">
                        <h2 style="cursor:move;" runat="server" id="H1">Personal data</h2>
                        <fieldset>	                          
                	        <p>
                                <label>Gender:</label>
                                <asp:DropDownList ID="clientPersDataGenderListDDL" runat="server" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="clientPersDataGenderList_SelectedIndexChanged"></asp:DropDownList>
                            </p>
                    
                            <asp:Panel ID="clientPersonalDataSimplePanel" runat="server" Visible="false">
                                <p>
                                    <label>Firts Name:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_FirstNameTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Last Name:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_LastNameTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Birth Date:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_BirthDateTextBox" ></asp:TextBox>
                                    <ajax:CalendarExtender ID="clientPersDataSimple_BirthDateCalendarExtender" runat="server" TargetControlID="clientPersDataSimple_BirthDateTextBox"></ajax:CalendarExtender>
                                </p>

                                <p>
                                    <label>Personal number (IDNP):</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_IDNPTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Buletin:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_BuletinTextBox" ></asp:TextBox>
                                </p>

                                <p>
                                    <label>Telefon / Fax:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_TelefonFixTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Telefon mobil:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_TelefonMobilTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Email:</label>
                                    <asp:TextBox runat="server" ID="clientPersDataSimple_EmailTextBox" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                        ErrorMessage="Wrong email!" ControlToValidate="clientPersDataSimple_EmailTextBox" 
                                        Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <ajax:ValidatorCalloutExtender 
                                        runat="Server"
                                        ID="ValidatorCalloutExtender2"                     
                                        TargetControlID="RegularExpressionValidator1" 
                                        Width="250px"
                                        PopupPosition="Right" />
                                </p>
                            </asp:Panel>

                                <asp:Panel ID="clientPersonalDataJuridicPanel" runat="server" Visible="true">
                                <p>
                                    <label>Full Name:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridFullNameTextBox" ></asp:TextBox>
                                </p>    
                                <p>
                                    <label>Registration nr.:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridRegistrationNRTextBox" ></asp:TextBox>
                                </p>                 
                                <p>
                                    <label>Contact Person:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridContactPersonTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Telefon / Fax:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridTelefonFixTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Telefon mobil:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridTelefonMobilTextBox" ></asp:TextBox>
                                </p>
                                <p>
                                    <label>Email:</label>
                                    <asp:TextBox runat="server" ID="clientPersData_juridEmailTextBox" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                        ErrorMessage="Wrong email!" ControlToValidate="clientPersData_juridEmailTextBox" 
                                        Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <ajax:ValidatorCalloutExtender 
                                        runat="Server"
                                        ID="ValidatorCalloutExtender3"                     
                                        TargetControlID="RegularExpressionValidator2" 
                                        Width="250px"
                                        PopupPosition="Right" />
                                </p>
                            </asp:Panel>
                            <div style="text-align:right;">
                                <asp:Button runat="server" ID="clientPersDataSaveBurtton" Text="Save" onclick="clientPersDataSaveBurtton_Click"  Width="100px"  />
                            </div>
                        </fieldset>
                    </asp:Panel>


                </ContentTemplate>
            </ajax:TabPanel>

        </ajax:TabContainer>



<%--        <ajax:TabContainer ID="detailsClientTabContainer"  runat="server" cssclass="ajax__myTab"  Width="100%" ActiveTabIndex="0" Height="24px">  

            <ajax:TabPanel ID="generalInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Generalizari&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <div style="float:left; width:20%;"> 
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
                    <div style="float:left; width:79%;"> 
                    </div>
                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="personalDataInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Date personale&nbsp; </HeaderTemplate>                	
                <ContentTemplate>

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
  
                    </ContentTemplate>			    
                </ajax:TabPanel>   
                     
        </ajax:TabContainer>    --%>   

    </asp:Panel>

</asp:Content>

