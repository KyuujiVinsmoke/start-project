Necessario
  Instalar o xampp
  Remover o ; do extension=zip no arquivo C:\xampp\php\php.ini
  Instalar o composer

--------------------------------------------------------------------------------------------------------------------------

Passo 01
  //C:\xampp\htdocs
  Coloque o projeto dentro da pasta htdocs

Passo 02
  //Instalar as dependencias do projeto (dentro da pasta C:\xampp\htdocs ... \start-project)
  composer install

Passo 03
  //Gerar automaticamente uma chave criptografada no arquivo .env (dentro da pasta C:\xampp\htdocs ... \start-project)
  php artisan key:generate

Passo 04
  //Iniciar o Servidor
  php artisan serve

  //Iniciar o servidor em host especifico
  php artisan serve --host 0.0.0.0

  //Iniciar o servidor em porta especifica
  php artisan serve --port 10000

Passo 05
  //Criar todas as tabelas do banco de dados
  php artisan migrate

  //Recriar e substitui todas as tabelas do branco de dados (cria as tabelas do zero)
  php artisan migrate:fresh

  //Recriar e substitui todas as tabelas do branco de dados (cria as tabelas do zero), preenchendo com os dados de teste (seeders)
  php artisan migrate:fresh --seed

Passo 06.01
  //Criar o modelo e a migração
  php artisan make:model Aluno -m

  //Criar a migração especificando
  php artisan make:migration Aluno --create=alunos

Passo 07
  //Criar a seeder
  php artisan make:seeder AlunoSeeder

Passo 08
  //Criar a controller
  php artisan make:controller EixoController

  //Criar a controller com CRUD
  php artisan make:controller EixoController -r

--------------------------------------------------------------------------------------------------------------------------

Model
  //01
  php artisan make:model Eixo -m
  php artisan make:model Nivel -m
  php artisan make:model Resource -m
  php artisan make:model Role -m

  //02
  php artisan make:model Curso -m
  php artisan make:model Permission -m

  //03
  php artisan make:model Categoria -m
  php artisan make:model Turma -m
  php artisan make:model User -m

  //04
  php artisan make:model Aluno -m
  php artisan make:model Documento -m

  //05
  php artisan make:model Comprovante -m

  //06
  php artisan make:model Declaracao -m

--------------------------------------------------------------------------------------------------------------------------

Seeder
  //01
  php artisan make:seeder EixoSeeder
  php artisan make:seeder NivelSeeder
  php artisan make:seeder ResourceSeeder
  php artisan make:seeder RoleSeeder

  //02
  php artisan make:seeder CursoSeeder
  php artisan make:seeder PermissionSeeder

  //03
  php artisan make:seeder CategoriaSeeder
  php artisan make:seeder TurmaSeeder
  php artisan make:seeder UserSeeder

  //04
  php artisan make:seeder AlunoSeeder
  php artisan make:seeder DocumentoSeeder

  //05
  php artisan make:seeder ComprovanteSeeder

  //06
  php artisan make:seeder DeclaracaoSeeder

--------------------------------------------------------------------------------------------------------------------------

Controller
  //01
  php artisan make:controller EixoController -r
  php artisan make:controller NivelController -r
  php artisan make:controller ResourceController -r
  php artisan make:controller RoleController -r

  //02
  php artisan make:controller CursoController -r
  php artisan make:controller PermissionController -r

  //03
  php artisan make:controller CategoriaController -r
  php artisan make:controller TurmaController -r
  php artisan make:controller UserController -r

  //04
  php artisan make:controller AlunoController -r
  php artisan make:controller DocumentoController -r

  //05
  php artisan make:controller ComprovanteController -r

  //06
  php artisan make:controller DeclaracaoController -r

--------------------------------------------------------------------------------------------------------------------------

Banco de Dados
  //01
  Schema::create('eixos', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->softDeletes();
    $table->timestamps();
  });

  Schema::create('niveis', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->softDeletes();
    $table->timestamps();
  });
  
  Schema::create('resources', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->timestamps();
  });

  Schema::create('roles', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->timestamps();
  });

  //02
  Schema::create('cursos', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->string('sigla');
    $table->integer('total_horas');
    $table->unsignedBigInteger('nivel_id');
    $table->foreign('nivel_id')->references('id')->on('niveis');
    $table->unsignedBigInteger('eixo_id');
    $table->foreign('eixo_id')->references('id')->on('eixos');
    $table->timestamps();
    $table->softDeletes();
  });

  Schema::create('permissions', function (Blueprint $table) {
    $table->unsignedBigInteger('role_id');
    $table->foreign('role_id')->references('id')->on('roles');
    $table->unsignedBigInteger('resource_id');
    $table->foreign('resource_id')->references('id')->on('resources');
    $table->boolean('permission');
    $table->primary(['role_id', 'resource_id']);
    $table->timestamps();
  });
      
  //03
  Schema::create('categorias', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->integer('maximo_horas');
    $table->unsignedBigInteger('curso_id');
    $table->foreign('curso_id')->references('id')->on('cursos');
    $table->timestamps();
    $table->softDeletes();
  });

  Schema::create('turmas', function (Blueprint $table) {
    $table->id();
    $table->unsignedBigInteger('curso_id');
    $table->foreign('curso_id')->references('id')->on('cursos');
    $table->integer('ano');
    $table->timestamps();
    $table->softDeletes();
  });

  Schema::create('users', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->string('email')->unique();
    $table->timestamp('email_verified_at')->nullable();
    $table->string('password');
    $table->unsignedBigInteger('role_id');
    $table->foreign('role_id')->references('id')->on('roles');
    $table->unsignedBigInteger('curso_id');
    $table->foreign('curso_id')->references('id')->on('cursos');
    $table->timestamps();
    $table->rememberToken();
  });

  //04
  Schema::create('alunos', function (Blueprint $table) {
    $table->id();
    $table->string('nome');
    $table->string('cpf');
    $table->string('email')->unique();
    $table->string('password');
    $table->unsignedBigInteger('user_id')->nullable();
    $table->foreign('user_id')->references('id')->on('users');
    $table->unsignedBigInteger('curso_id');
    $table->foreign('curso_id')->references('id')->on('cursos');
    $table->unsignedBigInteger('turma_id');
    $table->foreign('turma_id')->references('id')->on('turmas');
    $table->timestamps();
    $table->softDeletes();
  });

  Schema::create('documentos', function (Blueprint $table) {
    $table->id();
    $table->string('url');
    $table->float('horas_in');
    $table->string('status');
    $table->string('comentario');
    $table->float('horas_out');
    $table->unsignedBigInteger('categoria_id');
    $table->foreign('categoria_id')->references('id')->on('categorias');
    $table->unsignedBigInteger('user_id');
    $table->foreign('user_id')->references('id')->on('users');
    $table->timestamps();
    $table->softDeletes();
  });

  //05
  Schema::create('comprovantes', function (Blueprint $table) {
    $table->id();
    $table->float('horas');
    $table->string('atividade');
    $table->unsignedBigInteger('categoria_id');
    $table->foreign('categoria_id')->references('id')->on('categorias');
    $table->unsignedBigInteger('aluno_id');
    $table->foreign('aluno_id')->references('id')->on('alunos');
    $table->unsignedBigInteger('user_id');
    $table->foreign('user_id')->references('id')->on('users');
    $table->timestamps();
    $table->softDeletes();
  });

  //06
  Schema::create('declaracoes', function (Blueprint $table) {
    $table->id();
    $table->string('hash');
    $table->date('data');
    $table->unsignedBigInteger('aluno_id');
    $table->foreign('aluno_id')->references('id')->on('alunos');
    $table->unsignedBigInteger('comprovante_id');
    $table->foreign('comprovante_id')->references('id')->on('comprovantes');
    $table->timestamps();
    $table->softDeletes();
  });

--------------------------------------------------------------------------------------------------------------------------

Informações
  //Arquitetura de software do laravel
  MVC (Model-View-Controller)

  //Limpar rotas
  php artisan route:clear

  //Listar rotas
  php artisan route:list