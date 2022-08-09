# Work of the reproducibility group : repro-seir 
In this repository we have an implementation of a SEIR model in Netlogo as described [here](Repro_SEIR-1.pdf)

- In this model the time step is not clear (is it the day or an other time step ?)

## todo


## ODD (Grimm et al. 2006, 2010)

### Overview
#### Purpose

There are two objectives to this work: 
1. the model SEIR is well known, it is a translation from compartimental model in the concepts of multi-agent simulation The SEIR model is a compartmental model that can be solved by equations. So we will question the translation effects on the reproducibility of the model?
2. By implementing it in an agent-based model, we will question the influence of this translation (in the sense of Latour and Callon). This questioning will push us to use exploration tools to understand the simularity and disimilarity of translation

#### State variables and scales

To perform this translation, we consider only one type of agents, which can be in different states: S (Susceptible), E (Exposed), I (Infectious), R (Recovered).

Globally, we define `te` the mean incubation time, `ti` the mean infection time and `tr` the mean immunity time after infection. 

Each agent will have a private attribute `te`, `ti` and `tr` which will vary randomly following an exponential distribution of variable standard deviation `sd_expo_t`.

Because we are in a multi-agent system, space plays a role in the contagion. So we put in the public variables a contagion distance (`infectionRadius-i`)

The toric space consists of 33x33 cells. The space only serves as a support for the interactions. The agents have no effect on it.

Le pas de temps ... 

#### Process overview and scheduling

As the SEIR model is a compartmentalized model, we have chosen to model it as a finite state machine. 

The agents are in an initial state (S or I), they will go from one state to another following the following process: 
S -> E - I - R
^            |
|____________|

It is the time (ticks) that will determine the passage from one behavior to another for E, I and R. The passage from S to E is defined by the proximity of agent S with an agent I.

Once the agent has defined the behavior of its state, it will move. All agents move after changing state.

### Design concepts
#### Basic principles

In a finite state automaton, the realized actions are determined according to the events that occur. The action situation and the event defining the next action. The agents have a stack of actions that they will perform one after the other.

#### Emergence

There is an effect of the random movement of agents on the local dynamics of the epidemic. This effect is erased by the density of agents that we can have in the system.

#### Adaptation

Agents do not have the capacity to adapt. It is governed by external stimuli

#### Objectives

The agents have no objectives, they move in the space without goal

#### Learing 

Agents do not have a learning capacity.

#### Prédiction

Agents have no predictive capability

#### Sensing

Agents S are able to perceive agents I. If they perceive them in their perception area (`infectionRadius-i`), they change their state and become E.

#### Interaction

The only implemented interaction is the one that links the agents S and I by their perception

#### Stochastitity

The movement of agents is random. It is this movement that will generate local differences in time and space of the epidemic dynamics.

#### Collectives

Agents do not form groups and have no collective behavior

#### Observation

We collect : 

- the proportion of the population infected (`propInfected`)
- the proportion of the population never infected (`propSuseptible`)
- the proportion of the population exposed to the disease (`propExposed`)
- the proportion of the population in remission and therefore immune for a time (`propRecovered`)

### Details
#### Initialization

At initialization, we generate a (explorable) population of agents, and a proportion (%) of them will be infected (variable and explorable proportion).

#### Input dara

This model does not use data. It is a virtual population.

#### Submodels

## Some results

### Saltelli exploration 

We used [OpenMole](https://openmole.org/Sensitivity.html#Saltellismethod) to perform a sensitivity analysis on this model using Saltelli's method

#### first order 

 It is the variance after projecting along the dimension of the factor.


| **output**     | **popInit**         | **propInfecte**      | **teG**              | **tiG**                | **trG**               | **infectionRadiusI** | **sd_expo_t**        |
|----------------|---------------------|----------------------|----------------------|------------------------|-----------------------|----------------------|----------------------|
| propInfected   | -0.2618833021197146 | -0.1897622563028026  | -0.04315980808736693 | -0.011598849501233882  | -0.00437881186446075  | 0.03825048447295154  | 0.01934329179896787  |
| propSuseptible | 0.20468372783823577 | 0.009881723166589272 | 2.553862560075607E-4 | -2.3270382282721995E-4 | -8.399272891165563E-7 | 3.672801161307219E-4 | 2.553862560075607E-4 |
| propExposed    | 0.4267649924002832  | 0.24112973531541124  | 0.18365667076251332  | -0.027733105150649716  | 0.001074967370363857  | 0.10398479286811102  | -0.05734945018321909 |
| propRecovered  | -0.2618833021197146 | -0.1897622563028026  | -0.04315980808736693 | -0.011598849501233882  | -0.00437881186446075  | 0.03825048447295154  | 0.01934329179896787  |

#### Total order

The full behavior along the factor for all other possible parameter values. This corresponds to the total effect, i.e. first order but also interactions with other factors.

| **output**     | **popInit**         | **propInfecte**     | **teG**              | **tiG**              | **trG**               | **infectionRadiusI** | **sd_expo_t**         |
|----------------|---------------------|---------------------|----------------------|----------------------|-----------------------|----------------------|-----------------------|
| propInfected   | 0.5651698166782577  | 0.4362764975546598  | 0.040906111935236446 | 0.00925880931355133  | 0.004024661437198344  | 0.2081930578389597   | 0.007326178062612419  |
| propSuseptible | 0.3096391462987385  | 0.2418628798087571  | 3.94823128609378E-4  | 6.485874078977703E-4 | 3.8263308705805934E-4 | 0.024629448950542473 | 0.0013109342474738404 |
| propExposed    | 0.42442243869013047 | 0.28117036007792945 | 0.22377288851177024  | 0.15665070112255305  | 0.005814649360613771  | 0.18531038893750787  | 0.020980052366102772  |
| propRecovered  | 0.5651698166782577  | 0.4362764975546598  | 0.040906111935236446 | 0.00925880931355133  | 0.004024661437198344  | 0.2081930578389597   | 0.007326178062612419  |