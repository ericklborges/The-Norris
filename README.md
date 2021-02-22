# The Norris

## Considerações
Todo o fluxo de desenvolvimento foi registrado com o [GithubProjects](https://github.com/ericklborges/The-Norris/projects/1) conforme sugerido.
Aproveitei para adicionar alguns links ao longo da documentação que apontam para [Milestones](https://github.com/ericklborges/The-Norris/milestones?state=closed), [PullRequests](https://github.com/ericklborges/The-Norris/pulls?q=is%3Apr+is%3Aclosed) e [Issues](https://github.com/ericklborges/The-Norris/issues?q=is%3Aissue+is%3Aclosed) que considero importantes.
A documentação a seguir tem o objetivo de apresentar alguns comentários que considero relevantes sobre a maneira com que eu organizei o desenvolvimento e tomei algumas decisões.

## 💎 Configurações do projeto
Na pasta raíz do projeto:
1. Instale a versão do ruby especificada no arquivo [.ruby-version](.ruby-version)
2. Instale o gerenciador de gemas bundler  `$ gem install bundler`
3. Instale as Gemas   `$ Bundler install`
4. Instale as dependências  `$ Bundle exec pod install` 

## 🛠 Cobertura de testes
Basta rodar a build de testes do scheme `The-Norris`, ele também irá rodar os testes dos outros módulos.
* **The-Noris**: 88,0% (`112 tests`)
* **Interface**: 91,0% (`19 tests`)
* **Client**: 81,0% (`7 tests`)

## 🗺 Roadmap
### 1. [Setup](https://github.com/ericklborges/The-Norris/milestone/1?closed=1)
Nesta etapa eu fiz todo o planejamento do desenvolvimento, o que incluiu:
* [Estudar a API](https://github.com/ericklborges/The-Norris/issues/4)
* Desenhar os [componentes](https://github.com/ericklborges/The-Norris/files/5961759/Componentes.pdf), [telas](https://github.com/ericklborges/The-Norris/files/5961811/Telas.pdf), fluxos, estados, [cores](https://github.com/ericklborges/The-Norris/issues/1#issuecomment-775520694) e [fontes](https://github.com/ericklborges/The-Norris/issues/1#issuecomment-775521087) do aplicativo
* Mapeamento de [dependências](https://github.com/ericklborges/The-Norris/issues/5)
* Definição de [arquitetura](https://github.com/ericklborges/The-Norris/issues/2)

#### 🧰 Dependências
##### Lint
- **Swift Lint**: é simplesmente o lint com o qual eu estou habituado a trabalhar.

##### Gerenciamento de Assets
- **SwiftGen**: Gera arquivos que garantem o acesso seguro às imagens e strings do projeto.

##### Testes unitários
- **Quick**: Oferece sintaxe que favorece a escrita de testes unitários mais legíveis e organizados
- **Nimble**: Funciona bem em conjunto com `Quick`, trazendo ferramentas muito práticas de verificação
- **Nimble-Snapshots**: Testes de `Snapshot` integrados com a sintaxe do `Nimble`

#### 🏗 Arquitetura
##### Principal
O aplicativo será modularizado conforme [esta descrição](https://github.com/ericklborges/The-Norris/issues/2#issuecomment-775514832), e a arquitetura do aplicativo será **MVVM**, com a adição de uma camada que eu chamei de [service](The-Norris/Features/Facts/FactsList/Service/FactsListService.swift) para descarregar a **ViewModel** de regras de negócio relacionadas a tratamento de erros e consumo de dados oriundos da API e do Banco dados local.

##### Navegação
A navegação será baseada em ChildViewControllers, com o uso de uma camada chamada de "[FlowController](The-Norris/Features/Facts/FactsFlowController.swift)".

Esta abordagem se assemelha bastante ao Coordinator, porém a stack de "ChildCoordinators" toma proveito do próprio ciclo de vida das UIViewControllers com o uso de ChildViewControllers, o que trás vantagens durante a inicialização e finalização de fluxos.

##### Estados
Eu também usei uma implementação de "controller base" chamada "[StateViewController](https://github.com/ericklborges/The-Norris/pull/27)" para abstrair os principais estados de uma tela, também fazendo uso de ChildViewControllers.

### 2. [Foundation](https://github.com/ericklborges/The-Norris/milestone/2?closed=1)
Nesta etapa eu comecei a programar com o objetivo de concluir tudo o que eu considerei como recurso básico para o desenvolvimento da primeira feature, o que incluiu:
* Criação e configurações do projeto
* Adição de cores, imagens e fontes
* [Criação de componentes](https://github.com/ericklborges/The-Norris/pull/23)
* Criação do mecanismo de requisições [Client](https://github.com/ericklborges/The-Norris/issues/10)

### 3. [[MVP] Busca Simples](https://github.com/ericklborges/The-Norris/milestone/3?closed=1)
Na terceira etapa eu desenvolvi o que eu considerei o "Mínimo Produto Viável" do aplicativo proposto, o que incluiu:
* Tela de listagem dos fatos pesquisados
* Tela de busca

Após o desenvolvimento o usuário podia fazer uma pesquisa, ver os resultados listados e compartilhar um fato, sem as sugestões, histórico de pesquisas, ou qualquer persistência local.

### 4. [Nuvem de sugestões de pesquisa](https://github.com/ericklborges/The-Norris/milestone/4?closed=1)
Esta etapa contou com o desenvolvimento da busca de categorias, persistência local das mesmas, e exibição delas como sugestões na tela de pesquisa.
* As categorias são buscadas na api [somente uma vez, durante a inicialização do app](The-Norris/Features/Splash Screen/Controller/SplashScreenViewController.swift).
* São exibidas 8 categorias aleatórias como sugestão de pesquisa

### 5. [Histórico de pesquisas](https://github.com/ericklborges/The-Norris/milestone/5?closed=1)
O último incremento do escopo básico do projeto adicionou a lista de pesquisas passadas à tela de pesquisa, garantindo a ordem decrescente por data de pesquisa, e a proteção contra a inclusão de entradas repetidas no banco de dados.

### 6. [[Extra 2] Fatos Offline](https://github.com/ericklborges/The-Norris/milestone/6?closed=1)
Eu escolhi fazer o extra dois, desenvolvendo a persistência local de todos os resultados bem sucedidos de pesquisa, associados à query que foi feita para retorná-los. Eu usei o id de cada objeto "Fact" como constraint no Objeto do CoreData, impedindo que estas entradas se repetissem no banco de dados, mesma abordagem usada para que os "termos passados não fossem duplicados.
