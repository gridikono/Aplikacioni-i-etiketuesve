<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeFile="News.aspx.cs" Inherits="ALBNER.ner.News" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
       .GridviewDiv {font-size: 100%; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helevetica, sans-serif;}
    </style>
    <h2>Lajmet</h2>
    <div>
<asp:GridView runat="server" ID="gvNews" AutoGenerateColumns="False" DataKeyNames="id" OnPageIndexChanging="gvNews_PageIndexChanging"
    CssClass="table" CellPadding="4" AllowPaging="true" ForeColor="#333333" GridLines="None">
    <EditRowStyle BackColor="#2461BF" />
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<HeaderStyle CssClass="headerstyle" BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
<Columns>
<asp:BoundField DataField="id" HeaderText="Id" />
<asp:BoundField DataField="title" HeaderText="title" />
    <asp:HyperLinkField Text="Etiketo Unigrame" DataNavigateUrlFields="id" DataNavigateUrlFormatString="Ngram.aspx?id={0}&ngram_type=1" />
    <asp:HyperLinkField Text="Etiketo Bigrame" DataNavigateUrlFields="id" DataNavigateUrlFormatString="Ngram.aspx?id={0}&ngram_type=2" />
    <asp:HyperLinkField Text="Etiketo Trigrame" DataNavigateUrlFields="id" DataNavigateUrlFormatString="Ngram.aspx?id={0}&ngram_type=3" />
</Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#EFF3FB" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <SortedAscendingCellStyle BackColor="#F5F7FB" />
    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
    <SortedDescendingCellStyle BackColor="#E9EBEF" />
    <SortedDescendingHeaderStyle BackColor="#4870BE" />
</asp:GridView>
</div>
</asp:Content>





