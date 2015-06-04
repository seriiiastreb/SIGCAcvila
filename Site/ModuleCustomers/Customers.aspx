<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Customers.aspx.cs" Inherits="Customers" EnableEventValidation="false" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>


<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" Runat="Server"> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainPlaceHolder" Runat="Server"> 
    
    <asp:Panel ID="clientSelectionPanel" runat="server" Visible="false">
        <div style="text-align:left; width:40%; float:left;">
            <asp:RadioButton ID="juridicPersonRadioButton" runat="server" GroupName="personType" Checked="true" Text="Legal Entity"  AutoPostBack="true" OnCheckedChanged="juridicPersonRadioButton_CheckedChanged" />
            <asp:RadioButton ID="fizicPerson" runat="server" GroupName="personType" Checked="false" Text="Individual" AutoPostBack="true" OnCheckedChanged="juridicPersonRadioButton_CheckedChanged"/>

        </div>
        <div style="text-align:right; width:40%; float:right;">
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
                    <asp:BoundField DataField="clientID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
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

    <asp:Panel runat="server" ID="newClientPanel" CssClass="grid_5 box" style="display:none; width: auto; border:1px solid #000;">
        <h2 style="cursor:move;" runat="server" id="newClientHeader">New Client  <asp:Image ID="users_CancelButton" runat="server" ImageUrl="~/images/dialog_close.png"  Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;"/></h2>
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
        <ajax:TabContainer ID="detailsClientTabContainer"  runat="server" cssclass="ajax__myTab"  ActiveTabIndex="0" >  
            <ajax:TabPanel ID="generalInfoTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; General Info&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <div style="float:left; width:25%;" runat="server" id="generalInfo_personal">                                        
                    </div>

                    <div style="float:left; width:74%;"> 
                      
                    </div>
                </ContentTemplate>
            </ajax:TabPanel>

            <ajax:TabPanel ID="personalDataTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Personal data&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    <asp:Panel runat="server" ID="Panel3" CssClass="grid_4 box" style="border:1px solid #000;">
                        <h2>Personal data</h2>
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
                         
                        </fieldset>
                    </asp:Panel>


                      <asp:Panel ID="adresaPanel" runat="server"  CssClass="grid_4 box" style="border:1px solid #000;" > 
                          <h2>Address</h2>
                            <fieldset>	
                                <p>
                                    <label>Country:</label>
                                    <asp:DropDownList ID="vizaClientAddressCountryDDL" runat="server"  AutoPostBack="True"  onselectedindexchanged="vizaClientCountryDDL_SelectedIndexChanged" CssClass="microDDL"/>
                                </p>
                                <p>
                                    <label>Province:</label>
                                    <asp:DropDownList ID="vizaClientAddressClientRaionDDL" runat="server" CssClass="microDDL"/>
                                </p>
                                <p>
                                    <label>City:</label>
                                    <asp:TextBox ID="vizaClientAddressLocalitateaTextBox" runat="server" CssClass="microElement"/>
                                </p>
                                <p>
                                    <label>Address:</label>
                                    <asp:TextBox ID="vizaClientAddressAdresaTextBox" runat="server" CssClass="microElement"/>
                                </p>
                            </fieldset>
                        </asp:Panel>        

                    <div class="clear"></div>

                    <div style="text-align:center; margin:auto; width:100%;">
                        <asp:Button runat="server" ID="clientPersDataSaveBurtton" Text="Save personal data" onclick="clientPersDataSaveBurtton_Click"  Width="200px"  />
                    </div>
                </ContentTemplate>
            </ajax:TabPanel>

        <ajax:TabPanel ID="contractsTabPanel" runat="server">                
                <HeaderTemplate>&nbsp; Client contracts&nbsp; </HeaderTemplate>                	
                <ContentTemplate>
                    
                    <script language="javascript" type="text/javascript">
                        $(function () {
                            $.contextMenu({
                                selector: '.context-menu-clientcontracts',
                                trigger: 'none',
                                callback: function (key, options) {
                                    if (key == "delete") {
                                        if (confirm("Are you sure you want to delete?")) {
                                            doPost("clientContractsGridClik", key);
                                        }
                                    }
                                    else {
                                        doPost("clientContractsGridClik", key);
                                    }
                                },
                                items: {
                                    "add": { name: "Add", icon: "add", className: 'resetMarginLeft' },
                                    "edit": { name: "Edit", icon: "edit", className: 'resetMarginLeft' },                                   
                                    "delete": { name: "Delete", icon: "delete", className: 'resetMarginLeft' }
                                }
                            });
                        });


                        $(function () {
                            $("[id*=<%= clientContractsGridView.ClientID %>] td").mousedown(function (e) {

                                var selectedRowIndex = $(this).parent().index();
                                var hiddField = document.getElementById('<%= clientContracts_SelectedIndex_HiddenValue.ClientID %>');
                                hiddField.value = selectedRowIndex;

                                var gridID = '<%= clientContractsGridView.ClientID %>';
                                ResetGridSelection(gridID);

                                $(this).closest("tr").removeClass('odd');
                                $(this).closest("tr").toggleClass("selectedRow");

                                if (e.which == 3) //1: left, 2: middle, 3: right
                                {
                                    $(".context-menu-clientcontracts").contextMenu({ x: e.pageX, y: e.pageY });
                                }
                            });
                        });

                        $(function () {
                            $("#<%= contractsTabPanel.ClientID %>").mousedown(function (e) {
                                if (e.which == 3) {
                                    $(".context-menu-clientcontracts").contextMenu({ x: e.pageX, y: e.pageY });
                                }
                            });
                        });                           
                    </script>
                    
                    <div class="box context-menu-clientcontracts" style="min-height:200px; width:450px;">
                        <asp:HiddenField ID="clientContracts_SelectedIndex_HiddenValue" runat="server" />

                        <asp:GridView ID="clientContractsGridView" runat="server"
                            AutoGenerateColumns="false"
                            AlternatingRowStyle-CssClass="odd"
                            OnRowCreated="clientContractsGridView_RowCreated"
                            AllowPaging="false"  
                            SelectedRowStyle-CssClass = "selectedRow">
                            <Columns>
                                <asp:BoundField DataField="client_id" HeaderText="client_id"  HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" />
                                <asp:BoundField DataField="contract_id" HeaderText="contract_id"  HeaderStyle-CssClass="hidden"  ItemStyle-CssClass="hidden" />
                                <asp:BoundField DataField="contract_nr" HeaderText="Nr." />
                                <asp:TemplateField HeaderText="Date from">
                                    <ItemTemplate>
                                        <asp:Label ID="dateFromLabel" Width="100px" runat="server" Text='<%# ((Eval("date_from") != null && Eval("date_from") is DateTime) ?  ((DateTime)Eval("date_from")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                <asp:TemplateField HeaderText="Date To">
                                    <ItemTemplate>
                                        <asp:Label ID="dateToLabel" Width="100px" runat="server" Text='<%# ((Eval("date_to") != null && Eval("date_to") is DateTime) ?  ((DateTime)Eval("date_to")).ToString(Constants.ISODateBackwardDotsFormat) : "") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                <asp:BoundField DataField="active" HeaderText="Is Active" />
                            </Columns>
                        </asp:GridView>
                    </div>

                  


                    <asp:HyperLink ID="clientContractsHyperLink" runat="server" Style=" display:none;"></asp:HyperLink>

                    <ajax:ModalPopupExtender ID="clientContractPopupExtender" runat="server"     
                        TargetControlID="clientContractsHyperLink"
                        PopupControlID = "clientContractPanel" 
                        PopupDragHandleControlID="clientContractHeader"
                        CancelControlID="clientContractCloseButton"
                        DropShadow="true" >
                    </ajax:ModalPopupExtender>   

                    <asp:Panel runat="server" ID="clientContractPanel" CssClass="grid_4 box" style=" display:none; width: auto; border:1px solid #000;">
                        <h2 style="cursor:move;" runat="server" id="clientContractHeader"> Client Contract  <asp:Image ID="clientContractCloseButton" runat="server" ImageUrl="~/images/dialog_close.png" Width="23px" Height="23px" style="float:right; cursor:default; margin-top: -5px;" /></h2>
                        <fieldset>			        
			                <p>
                                <asp:HiddenField ID="clientContractActionHiddenField" runat="server" />
                                <asp:HiddenField ID="contractSelectedContractIDHiddenField" runat="server" />

				                <label>Nr: </label>
                                <asp:TextBox ID="clientContractNrTextBox" runat="server" ></asp:TextBox>                   
			                </p>
                            <p>
				                <label>Date from: </label>
                                <asp:TextBox ID="clientContractDateFromTextBox" runat="server" ></asp:TextBox>   
                                <ajax:CalendarExtender ID="clientContractDateFromCalendareExtender" runat="server" TargetControlID="clientContractDateFromTextBox"></ajax:CalendarExtender>                
			                </p>
                            <p>
				                <label>Date to: </label>
                                <asp:TextBox ID="clientContractDateToTextBox" runat="server" ></asp:TextBox>   
                                <ajax:CalendarExtender ID="clientContractDateToCalendareExtender" runat="server" TargetControlID="clientContractDateToTextBox"></ajax:CalendarExtender>                
			                </p>
                            
				              <asp:CheckBox ID="clientContractActiveCheckBox" runat="server" Text="Is Active:" TextAlign="Left"/>
                                                   
			                			   
                
                            <div style="text-align:right;">
                                <asp:Button ID="clientContractSaveButton" runat="server" Text="Save" Width="100px"  CausesValidation="false" onclick="clientContractSaveButton_Click"  />  
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

