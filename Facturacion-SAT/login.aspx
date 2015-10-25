<%@ Page Language="VB" AutoEventWireup="false" CodeFile="login.aspx.vb" Inherits="login" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Gentrac Monitoreo</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.poptrox.min.js"></script>
		<script src="js/jquery.scrolly.min.js"></script>
		<script src="js/jquery.scrollex.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/init.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
			<link rel="stylesheet" href="css/style-normal.css" />
		</noscript>
		<!--[if lte IE 9]><link rel="stylesheet" href="css/ie/v9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
	</head>
    <body>

        			</ul>
					</nav>

			</header>
         <div id="destino"  type ="hidden"></div>
		<section id="intro" class="main style1 dark fullscreen">
				<div class="content container 100%">
					<header>
						<h2>MONITOREO</h2>
					</header>
						<p>Bienvenido al <strong>Sistema de Monitoreo</strong> 
				
					<footer>
						<a href="#one" class="button style2 down">More</a>
					</footer>
				</div>
			</section>
            
           	<section id="one" class="main style2 right dark fullscreen">
				<div class="content box style2">
					<header>
			
                    <h2>Ingresar</h2>
					</header>
                <form runat="server" id="IniciarSesion">
                    
                    <p>Iniciar Sesión Para Acceder Al Sistema</p>
                    <asp:TextBox ID="TxtUser" runat="server" name="login" placeholder="Usuario" CssClass="form-control uname"></asp:TextBox>
                    <asp:TextBox ID="TxtPass" TextMode="Password" runat="server" name="password" placeholder="Contrasena" CssClass="form-control pword"></asp:TextBox>
                    <!--<a href=""><small>Forgot Your Password?</small></a>-->
                    <asp:Button ID="BtnLogin" runat="server" Text="Ingresar" CssClass="btn btn-success btn-block"/>
                    <small><asp:Label ID="LblEstado" runat="server" Text=""></asp:Label> </small>
                </form>
           	</div>
				<!--<a href="#two" class="button style2 down anchored">Next</a> -->
                   	<ul class="menu">
						<li></li><li><a href=>Todos los derechos reservados a Union Systems</a></li>
					</ul>
			</section>
       
        
 	

				
				<!-- Menu -->
				

			

       <script>

           jQuery(document).ready(function () {
               $("html,body").animate({ scrollTop: $("#destino").offset().top }, 550);
           })
               </script>
</body>
</html>
