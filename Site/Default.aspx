<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="fc" TagName="FilterControl" Src="~/Controls/FilterWindow.ascx" %>

<asp:Content ID="headContent" ContentPlaceHolderID="HeadContent" Runat="Server">    
    <script type="text/javascript" src="Scripts/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.helper.js"></script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:Panel ID="mainPagePanel" runat="server" Visible="False">              
            <div class="module" style="width:30%; height:500px; float:left;">  
			    <div class="moduleHeader" style="position:relative;"> HOT PANEL </div>  
			    <div class="module_content" style="height: 440px; overflow-y: scroll; margin:10px 5px 0 10px !important;">
				        
			    </div>
            </div>  

        
            <div style="width:60%; height:500px; float:left;">

                <div class="module" style=" width:250px; height:100px; float:left; ">
                    <div class="moduleHeader">Clienti</div>
                    <div class="module_content">
                        <div class="leftColumn" style="padding-top:10px; text-align:center;"  >
                            <asp:HyperLink ID="newClientHyperLink" runat="server">Nou</asp:HyperLink> 
                        </div>
                        <div class="rightColumn" style="padding-top:10px; text-align:center;" >
                            <fc:FilterControl ID="clientFilter" runat="server" Height="250px" Width="400px"  AllowMultiSelection="false" SelectButtonText="Client List" SelectButtonWidth="120px" TitleWindow="Lista Clientilor inregistrati" OnEntrySelected="ClientSelecetd_Event" />
                        </div>
                    </div>
                </div>
                                
               
                <div class="module" style=" width:250px; height:150px; float:left; ">
                    <div class="moduleHeader">Contabilitate</div>
                    <div class="module_content">                      
                    </div>
                </div>

                <div class="module" style=" width:520px; height:150px; float:left;  ">
                    <div class="moduleHeader">Rapoarte</div>
                    <div class="module_content" style=" height:100px; overflow-y: scroll; margin: 5px 5px 0 5px !important;"> 

                      <%--   <asp:HyperLink ID="RPT_PAR_HyperLink" runat="server">PAR - raport</asp:HyperLink>     
                         <br />  
                         <asp:HyperLink ID="RPTListOfPaymentsInPeriodHyperLink" runat="server">Rambursari planificate</asp:HyperLink>     
                         <br />            
                         <asp:HyperLink ID="RPTClientPersonalReportHyperLink" runat="server">Raportul datelor personale</asp:HyperLink>      
                         <br />            
                         <asp:HyperLink ID="RPTListaCreditelorAcordateHyperLink" runat="server">Lista creditelor acordate</asp:HyperLink>    
                         <br />            
                         <asp:HyperLink ID="RPTConsulEvalHyperLink" runat="server">Consultari / Evaluari</asp:HyperLink>           
                          <br />  
                         <asp:HyperLink ID="RPTLoansPartOfCreditLinesHyperLink" runat="server">Lista tuturor creditorilor ce fac parte dintr-o linie de credit</asp:HyperLink>                                                                                                         --%>
                    </div>
                </div>

                <div class="module" style=" width:180px; height:200px; float:left; ">
                    <div class="moduleHeader">Curs Valutar BNM</div>
                    <div class="module_content">    
                        <div style="text-align:center;color: #000; font-size: 13px;"><asp:Label ID="changeRateDateLabel" runat="server"></asp:Label></div>
                        <table style="padding: 14px 0px; color: #000; font-size: 12px;" cellpadding="0" cellspacing="0" border=" 0" align="center">
	                        <tbody>
		                        <tr>
			                        <td valign="top">
				                        <img src="App_Images/eur.png" alt="" />
			                        </td>
			                        <td style="padding-left:3px; padding-right:3px;">EUR</td>
			                        <td align="right"><asp:TextBox ID="cursEUROTextBox" runat="server" MaxLength="7" Width="50px" Style="background-color:transparent; border:none;"></asp:TextBox></td>
                                    <td style="padding-left:3px;">MDL</td>
		                        </tr>
		                        <tr>
			                        <td valign="top">
				                        <img src="App_Images/usd.png" alt="" />
			                        </td>
			                        <td style="padding-left:3px; padding-right:3px;">USD</td>
			                        <td align="right"><asp:TextBox ID="cursUSDTextBox" runat="server" MaxLength="7" Width="50px" Style="background-color:transparent; border:none;"></asp:TextBox></td>
                                    <td style="padding-left:3px;">MDL</td>
		                        </tr>
	                        </tbody>
                        </table>     
                        <div style=" margin:auto; width: 50px;"><asp:Button ID="currencyRateUpdateButton" runat="server" Text="Salvare" OnClick="currencyRateUpdateButton_Click"  visible="false"/> </div>             
                    </div>                   
                </div>
            </div>    

    </asp:Panel>

</asp:Content>

