{% extends "bootstrap/base.html" %}
{% block title %}Score App{% endblock %}

{% block styles %}
    {{super()}}
    <link rel="stylesheet" href="{{url_for('.static', filename='css/dashboard.css')}}">
{% endblock %}

{% block content %}
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Modo Leitor de Tela</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
          <a class="navbar-brand" href="#">Score APP</a>
		</div>
    <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Painel de Controle</a></li>
            <li><a href="#">Configurações</a></li>
            <li><a href="#">Perfil</a></li>
            <li><a href="{{ url_for('logout') }}">Deslogar</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Procurar...">
          </form>
        </div>
      </div>
    </nav>
	
	
	
    <div class="container">
	{% with messages = get_flashed_messages(with_categories=true) %}
  {% if messages %}
    <ul class=flashes>
    {% for category, message in messages %}
      <li class="alert alert-{{ category }}">{{ message }}</li>
    {% endfor %}
    </ul>
  {% endif %}
{% endwith %}
      <div class="starter-template">
        <center><h1>Score APP</h1>
        <p class="lead">Sistema automatizado de Triagem de Atendimento</p></center>
      </div>
	  <center><h3>Acesse a sua conta para ter acesso a todo o sistema!</h3></center>
	  <center>Ainda não possui uma conta? - <a href="/registra">Registrar-se</a></center>
	  <center>Já possui uma conta? - <a href="/login">Acessar o sistema</a></center>
	  
	  

    </div><!-- /.container -->
{% endblock %}