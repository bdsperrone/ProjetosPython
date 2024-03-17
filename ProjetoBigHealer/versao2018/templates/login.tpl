{% extends "bootstrap/base.html" %}
{% import "bootstrap/wtf.html" as wtf %}
{% block html_attribs %} lang="pt-br"{% endblock %}
{% block title %}Score APP - Login{% endblock %}

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
	
    <div class="container-fluid">
      <div class="row">
{% with messages = get_flashed_messages() %}
      {% if messages %}
       <ul class=flashes>
      {% for message in messages %}
       <li>{{ message }}</li>
      {% endfor %} 
      {% endif %}
      {% endwith %}
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Painel de Controle<span class="sr-only">(current)</span></a></li>
            <li><a href="/pacientes">Pacientes</a></li> 
            <li><a href="prontuarios">Prontuários</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		
		
	<h2 class="form-signin-heading">Digite o usuário e a senha para acessar o sistema</h2>
{% with messages = get_flashed_messages(with_categories=true) %}
  {% if messages %}
    <ul class=flashes>
    {% for category, message in messages %}
      <li class="alert alert-{{ category }}">{{ message }}</li>
    {% endfor %}
    </ul>
  {% endif %}
{% endwith %}
      <form class="form-signin" method="POST" action="/login">
        {{ form.hidden_tag() }}
        {{ wtf.form_field(form.username) }}
        {{ wtf.form_field(form.password) }}
        {{ wtf.form_field(form.remember) }}
        <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
      </form>

    </div> <!-- /container -->
{% endblock %}