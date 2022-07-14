Carlos Henrique Martins, 145646  
Disciplina - MC426 1S 2021


# PetHere

PetHere é um projeto de uma aplicação que facilita a busca de animais perdidos.

O Projeto consiste em uma aplicação mobile (atualmente apenas para *iOS*) capaz de atrelar e ler etiquetas NFC que armazenam as informações de contato do dono de um animal de estimação


# Repositório (A3)
O Projeto conta com uma branch principal **develop** da qual são criadas novas branchs de feat/* onde serão desenvolvidas as *issues* abertas para desenvolvimento.

![image](./Files/GitFlow/Branchs.png)

* O Historico das Issues pode ser consultado [aqui](https://gitlab.com/pethere1/pethere-ios/-/issues)

* O historico de desenvolvimento pode ser acessado [Aqui](https://gitlab.com/pethere1/pethere-ios/-/network/develop)  

* Nota: Por conta de estar sozinho no projeto, muitos dos merges foram feitos sem Pull Requests.


# Roteitor de entrevistas (A4)
O projeto não possuiu um roteiro de entrevistas com usuários, entretando a idéia da aplicação surgiu com base em um outro projeto no qual trabalhei em 2017 que consistia em uma aplicação junto a um localizador GPS para cães. Resultado de uma pesquisa de mercado realizada na época.

# Arquitetura do projeto (A5)

## Arquitetura de uso C4
O projeto consiste em uma aplicação mobile que permite cadastrar um pet e atrelar uma tag nfc a este cadastro.
Ao ler uma tag NFC que contenha o id de um pet é criado um registro que contem as informações de quem leu e da localização que foi lida.  
O leitor pode ver as informações de contato do dono que registrou o pet lido.  
O dono de um Pet pode ver o histórico de registro do seu pet e as informações de contato de quem fez a leitura.  

![image](./Files/DesignPattern/C4.png) 

## **Arquitetura de código**
O Projeto foi desenvolvido usando o Design Pattern **MVVM-C**  
(**M**odel - **V**iew - **V**iew**M**odel - **C**oordinator )

## **Coordinator**
O **coordinator** tem como responsabilidade orquestrar a navegação da aplicação e criar os módulos (ViewModel - View) apresentados conforme o usuário interage com o software

A comunicação com o Coordinator é feita através de um __CoordinatorProtocol, os ViewModels recebem a referencia desta interface durante a sua inicialização.  
**Exemplo:**  
![image](./Files/DesignPattern/CoordinatorProtocol.png)  

* A implementação dessa interface é de responsabilidade do próprio Coordinator  


## **ViewModel**  
O **ViewModel** é responsável pelas regras de negócio da tela a qual o usuário está navegando.  
Ele possui referência a interface do **Coordinator** no qual foi criado e recebe as informações por meio da implementação do _ViewModelProtocol (utilizado pela View para notificar as ações do usuário) 

* Exemplo: **ViewModelProtocol**  
![image](./Files/DesignPattern/LoginViewModelProtocol.png)  

* Exemplo: **ViewModel**  
![image](./Files/DesignPattern/LoginViewModel.png)  

* Nota: O **ViewModel** também possui uma referência a interface _ViewProtocol a qual usa para notificar o usuário o status de suas ações
  
## View
A **View** é responsavel pela interação do usuário com a aplicação ela carrega os componentes visuais e comunica-se com o ViewModel através do _ViewModelProtocol.  
A View implementa a interface _ViewProtocol na qual recebe as inforções vindas do ViewModel para notificar o usuário.
* Exemplo: **LoginViewController**  
![image](./Files/DesignPattern/LoginViewProtocol.png)
* Exemplo: **LoginView**
![image](./Files/DesignPattern/LoginView.png)
* A Maior parte do layout da aplicação foi feita usando UIStoryboard (recurso visual que permite a construção de componentes de layout WYSIWYG). Entretanto alguns componentes internos das Views foram feito usando ViewCode
* Exemplo: **LoginViewXib**  
![image](./Files/DesignPattern/LoginViewXib.png)

* Nota: O projeto possui componentes customizados, foi-se criada uma partição contendo os elementos customizados a fim de posteriormente possuir-se um módulo com os componentes do layout feitos exclusivamente para manter a identidade visual do projeto (DesignSystem).  
Pode-se consultar os componentes em: [PetHere - Design System](https://gitlab.com/pethere1/pethere-ios/-/tree/develop/PetHere/Source/Design%20System) 

## Model
Os **Models** são os objetos que carregam as informações obtidas atraves do input do usuário ou recuperadas do Backend.

* Exemplo: **Pet**  
![image](./Files/DesignPattern/PetModel.png)

## Visão geral
Eis o diagrama geral com a arquitetura utilizada na aplicação e seus respectivos módulos:  

![image](./Files/DesignPattern/MVVMC426.png)

# Testes (A6)

Os Testes foram aplicados nas camadas de **ViewModel** (responsável pelas regras de negócio da aplicação) do projeto

A métodologia de testes utiliza as bibliotecas [Quick/Nimble](https://github.com/Quick/Nimble#custom-failure-messages) que permitem implementar os testes de uma forma mais descritiva que se assemelha mais a jornada do usuário.
 
Foram aplicados testes nas camadas de:
  * [HomeViewModel](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/PetHereTests/Source/Modules/Home/Home/HomeViewModelSpec.swift)
  * [LoginViewModel](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/PetHereTests/Source/Modules/Main/Login/LoginViewModelSpec.swift)
  * [SignInViewModel](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/PetHereTests/Source/Modules/Main/SignIn/SignInViewModelSpec.swift)
  * [UserProfileViewModel](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/PetHereTests/Source/Modules/Home/UserProfile/UserProfileViewModelSpec.swift)

![image](./Files/Tests/TestScheme.png)


# Automação (A7)

* A automação foi feita inicialmente utilizando o Bitrise e Fastlane para rodar os testes implementados.  
![image](./Files/CI/Bitrise.png)
O arquivo de configuração do Bitrise pode ser visto [Aqui](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/bitrise.yml)  
O arquivo de configuração do Fastlane pode ser visto [Aqui](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/fastlane/Fastfile)  

  
* Foi feito uma integração com o CI do GitLab mas há um problema com versões divergente do Bundler
![image](./Files/CI/BundleError.png)
O arquivo de configuração do CI do GitLab pode ser visto [Aqui](https://gitlab.com/pethere1/pethere-ios/-/blob/develop/.gitlab-ci.yml)  

# Funcionalidades

O projeto conta com as funcionalidade de **Login** e **Registro**, utilizando a plataforma [Firebase](https://console.firebase.google.com/u/0/project/pet-here/overview) como backend.

As funcionalidades principais do projeto são:  
* Escrita das informações de contato do Pet em Tag NFC (atrelada as coleiras dos Pets)

* Leitura da tags NFC contendo o identificador do Pet, o qual é utilizado para acessar as informações de contato do Dono.

* Mapa contendo o histórico de leitura do Pet cadastrado.  

## Demonstrações
* **Sign In**   
Cadastro com Nome, Email, Telefone e Senha.   
**Video:**   
<figure class="video_container">
  <video controls="true" allowfullscreen="true" width="320" height="240">
    <source src="./Files/Videos/SignIn.mp4" type="video/mp4">
  </video>
</figure>

* **Log In**  
Entrada com Email e Senha.   
**Video:**   
<figure class="video_container">
  <video controls="true" allowfullscreen="true" width="320" height="240">
    <source src="./Files/Videos/LogIn.mp4" type="video/mp4">
  </video>
</figure>


* **Editar Perfil**  
Possibilidade de editar as informações de nome e número para contato.  
**Video:**   
<figure class="video_container">
  <video controls="true" allowfullscreen="true" width="320" height="240">
    <source src="./Files/Videos/Login+Main.mp4" type="video/mp4">
  </video>
</figure>

* **Cadastrar Animal**  
Cadastrar animal de estimação com nome e descrição e atrelar cadastro a tag NFC.  
**Demo:**  
<figure class="video_container">
  <video controls="true" allowfullscreen="true" width="320" height="240">
    <source src="./Files/RegisterPet.mp4" type="video/mp4">
  </video>
</figure>

* **Leitura de Tag**  
Ler tag NFC atrelada ao animal e ter as informações de contato do dono.  
**Demo:**  
<figure class="video_container">
  <video controls="true" allowfullscreen="true" width="320" height="240">
    <source src="./Files/TagRegister.mp4" type="video/mp4">
  </video>
</figure>

* Caso tenha problemas em visualizar os vídeos [Clique Aqui](https://gitlab.com/pethere1/pethere-ios/-/tree/develop/Files/Videos)

