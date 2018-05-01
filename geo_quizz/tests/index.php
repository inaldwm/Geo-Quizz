<!DOCTYPE HTML>
<html>

	<?php
	try{
		// On se connecte à MySQL
		$bdd = new PDO('mysql:host=localhost;dbname=geo_quizz_bd;charset=utf8', 'root', 'root');
	}catch(Exception $e){
		// En cas d'erreur, on affiche un message et on arrête tout
		die('Erreur : '.$e->getMessage());
	}
	session_start();
	?>				
	
<head>

	<title>Site Personnel - Fariziala Melvyn</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" href="style.css" />
	
</head>

<body class="homepage">
	<div id="main-wrapper">
					<img  class='banniere' src='images/banniere.jpg'>

					<nav class="navbar navbar-default sidebar" role="navigation">
						<div class="container-fluid">
						
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
									<a  href="index.php">CMS Melvyn Fariziala</a>
								</button>      
							</div>
							
							<div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
								<ul class="nav navbar-nav">
									
									<?php
									$reponse = $bdd->query("SELECT * FROM rubrique ORDER BY date");		
										while ($donnees = $reponse->fetch()){
											
											echo"<li  class='dropdown'>";
												
												echo"<form action='inc/detail.inc.php' method='POST'>";
													$idRubrique= htmlspecialchars($donnees['idRubrique'], ENT_SUBSTITUTE, "UTF-8");
													echo"<td ><button type='submit' name='idRubrique' value='$idRubrique'>".$donnees['rubrique']."</button><td >";
												echo"</form>";
												
												if (isset($_SESSION['login'])) {
													echo"<div>";
														echo"<form action='inc/editer.inc.php' method='POST'>";
															echo"<td ><button type='submit'  name='idRubrique' value='$idRubrique'><img src='images/modifier.png'></</button><td >";					
														echo"</form>";

														echo"<form action='inc/supprimer.inc.php' method='POST'>";
															echo"<td ><button type='submit'  name='idRubrique' value='$idRubrique'><img src='images/supprimer.png'></</button><td >";					
														echo"</form>";
													echo"</div>";

												}
												
											echo"</li>";
										}?>

							</div>

						</div>	
					</nav>		

				</div>			
				
			</div>
		</div>
	</div>
	

	
	
	
	<?php
									
	if (isset($_SESSION['login'])) {
		echo"<a href='inc/deconnexion.inc.php'> <img  class='admin' src='images/admin.png'> </a>";
	
	}else{
				echo"<a href='inc/connexion.inc.php'> <img  class='admin' src='images/admin.png'> </a>";
	}
	if (isset($_SESSION['login'])) {
		
		echo"<form   action='inc/creer.inc.php' method='POST'>";
			echo"<button type='submit'  name='idRubrique'><img  class='ajout' src='images/ajouter.png'></</button>";					
		echo"</form>";
	}
	?>
									



	<footer >
		
				<div class='message'>&copy; Melvyn Fariziala. All rights reserved</div>
					
	</footer>
	

</body>
</html>