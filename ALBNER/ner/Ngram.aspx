<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" ClientIDMode="Static" CodeFile="Ngram.aspx.cs" Inherits="ALBNER.ner.Ngram" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type = "text/javascript">
        function BlockUI(elementID) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () {
                $("#" + elementID).block({
                    message: '<table align = "center"><tr><td>' +
             '<img src="http://192.168.190.1/images/loadingAnim.gif"/></td></tr></table>',
                    css: {},
                    overlayCSS: {
                        backgroundColor: '#000000', opacity: 0.5
                    }
                });
            });
            prm.add_endRequest(function () {
                $("#" + elementID).unblock();
                HighlightUpperCaseInGV();
                HighlightUpperCaseInNewsCnt();
            });
        }
        $(document).ready(function () {

            BlockUI("<%=pnlAddEdit.ClientID %>");
            $.blockUI.defaults.css = {};
            HighlightUpperCaseInGV();
            HighlightUpperCaseInNewsCnt();
    });
        function Hidepopup() {
            $find("popup").hide();
            return false;
        }
</script> 
<style>
    .modalBackground 
     {
	   background-color:Black;
	   filter:alpha(opacity=90);
	   opacity:0.8;
     }
   .modalPopup {
	   background-color:#FFFFFF;
	   border-width:3px;
	   border-style:solid;
	   border-color:black;
	   padding-top:10px;
	   padding-left:10px;
	   width:300px;
	   height:140px;
     }
     
    #news_area {background-color:#EFF3FB;}  
    .ngjyra {background-color:yellow}
    #news_area, .GridviewDiv {font-size: 100%; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helevetica, sans-serif;}
    </style>
    <script type="text/javascript" id="addColorScript">
        function HighlightUpperCaseInGV()
        {
            $('span[id^="lbl_entity"]').each(function () {
                var t = $(this).text();
                if (t.charAt(0) === t.charAt(0).toUpperCase()) {
                    $(this).addClass("ngjyra");
                }
            });
        }

        function HighlightUpperCaseInNewsCnt() {
            $('p').each(function () { 
                r = /[A-Z0-9]\w*/g;
                function f(word)
                {
                    return '<span class="ngjyra">' + word + '</span>'
                }
                h = $(this).html(); 
                h = h.replace(r, f); 
                $(this).html(h); 
            })
        }

    </script>
    <script id="ScrollNews">
        $(window).scroll(function () {
            $("#news_area").stop().animate({ "marginTop": ($(window).scrollTop()) + "px", "marginLeft": ($(window).scrollLeft()) + "px" }, "slow");
        });
    </script>
<div class="container-fluid">
  <div class="row">
    <div class="col-sm-6" id="news_area">
        <h2 id="h_news_title" runat="server"></h2> <br />
       <span id="span" runat="server"></span>
       <asp:Literal id="ltl_newscontent" runat="server"></asp:Literal>
    </div>
<div class="col-sm-6">
     <br />
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
         <asp:GridView ID="gvNgrams" runat="server" CssClass="table" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">  
            <AlternatingRowStyle BackColor="White" />
            <Columns>                    
                <asp:BoundField DataField = "nid" HeaderText = "id" />
                <asp:TemplateField HeaderText="Entiteti">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_entity" runat="server" Text='<%#Eval("entity") %>'></asp:Label>  
                    </ItemTemplate>   
                </asp:TemplateField>  
                <asp:TemplateField HeaderText="Etiketa">  
                    <ItemTemplate>  
                        <asp:Label ID="lbl_entity_type" runat="server" Text='<%#Eval("entity_type") %>'></asp:Label>  
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:TextBox ID="txt_entity_type" runat="server" Text='<%#Eval("entity_type") %>'></asp:TextBox>  
                    </EditItemTemplate>  
                </asp:TemplateField>  
                <asp:TemplateField ItemStyle-Width = "30px" HeaderText = " ">
                   <ItemTemplate>
                      <asp:LinkButton ID="lnkEdit" runat="server" Text = "Etiketoje" OnClick = "Edit"></asp:LinkButton>
                   </ItemTemplate>
               </asp:TemplateField>
            </Columns>  
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView> 
    <asp:Button ID="goToNext" runat="server" OnClick="GoToNextNews" Text="Lajmi i radhes" />
<asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" style = "display:none">
<asp:Label Font-Bold = "true" ID = "Label4" runat = "server" Text = "Vendos etiketen" ></asp:Label>
<br />
<table align = "center">
<tr>
<td>
<asp:HiddenField ID="hfID" runat="server" />
<asp:Label ID = "lbl_edit_Entity" runat = "server" Text = "Entiteti: " ></asp:Label>
</td>
<td>
<asp:DropDownList ID="ddl_Entities" runat="server" CssClass="form-control">
    <asp:ListItem Value="PERSON"></asp:ListItem>
    <asp:ListItem Value="VEND"></asp:ListItem>
    <asp:ListItem Value="ORGANIZATE"></asp:ListItem>
    <asp:ListItem Value="NUMER"></asp:ListItem>
    <asp:ListItem Value=" "></asp:ListItem>
</asp:DropDownList>
    <br />
</td>
</tr>
<tr>
<td>
<asp:Button ID="btnSave" CssClass="btn" runat="server" Text="Ruaj" OnClick = "Save" />
</td>
<td>
<asp:Button ID="btnCancel" CssClass="btn" runat="server" Text="c bej" OnClientClick = "return Hidepopup()"/>
</td>
</tr>
</table>
</asp:Panel>
<asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
<cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
PopupControlID="pnlAddEdit" TargetControlID = "lnkFake"
BackgroundCssClass="modalBackground">
</cc1:ModalPopupExtender>
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID = "gvNgrams" />
<asp:AsyncPostBackTrigger ControlID = "btnSave" />
</Triggers>
</asp:UpdatePanel>
    </div>
  </div>
</div>  
</asp:Content>
   