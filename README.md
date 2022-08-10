# Work of the reproducibility group : repro-seir 
In this repository we have an implementation of a SEIR model in Netlogo as described [here](Repro_SEIR-1.pdf)

- In this model the time step is not clear (is it the day or an other time step ?)

## todo

- There is something to do with space (at least the Moran index). Because there are spatial phenomena that are linked to the movements 

![](./img/m0seir_capture_%C3%A9cran.png)


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
```
S -> E - I - R
^            |
|____________|
```

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

##### SM1 - S (Susceptible), 
##### SM2 - E (Exposed), 
##### SM3 - I (Infectious), 
##### SM4 - R (Recovered)
##### SM5 - movements

## Some results

### Saltelli exploration 

We used [OpenMole](https://openmole.org/Sensitivity.html#Saltellismethod) to perform a sensitivity analysis on this model using Saltelli's method.

360 sim x 50 grp = 18 000 simulations

#### Total order

The full behavior along the factor for all other possible parameter values. This corresponds to the total effect, i.e. first order but also interactions with other factors.

![geom bar for total order indice](./results_saltelli/img/totalOrderIndices.png)

it seem than `trG` and `sd_expo-t` doesn't play un role in this model