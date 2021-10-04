# Exploring the many-body localization transition in momentum space

The emergence of thermodynamics from quantum mechanics is a foundational matter in physics.
Namely, how can one reconcile the information-preserving unitary evolution of quantum states with the second law of thermodynamics? Many-body localizing systems are examples of systems whose time evolution is asymptotically athermal - local correlations indefinitely retain information about their initial conditions, as opposed to tending towards a thermal distribution. 

Experiments in ultracold atoms using quantum gas microscopes have begun to realize and explore properties of many-body localized systems. The recent emergence of new momentum detection modalities provide a way forward to investigate currents and dynamical correlations in these fascinating systems. State of the art machines are able to create and control quantum systems of a dozen atoms in a quasirandom lattice and obtain single-site population measurements. 

The aim of this project is to predict measurable outcomes in future devices, and explore the structure and dynamics of interacting many-body systems. It is grossly a programming project, but as with all computational quantum mechanics there is a need for some sound theory of many-body quantum physics and algorithmic complexity.

## Objectives

This project will explore the static and dynamic properties of the Aubry-Andre model, a variant of the Bose-Hubbard model.

The Bose-Hubbard model is a lattice model which describes interacting bosons in a periodic potential, characterized by a tunnelling rate J and an interaction strength U. These systems have been realized in ultracold atom labs, trapping the atoms in optical lattice potentials and controlling the tunnelling rate via the depth of the lattice (that is, the intensity of the trapping lasers). So-called *quasirandom* lattices can be created by applying a second laser along the axes of the lattice with incommensurate wavelengths, or by overlaying a laser speckle pattern. Breaking the translational symmetry of the Bose-Hubbard model gives rise to the Aubry-Andre model.

The objective of this project is to write a program that produces a matrix representation of the Aubry-Andre Hamiltonian. Thereafter, one can exactly diagonalize the Hamiltonian with existing linear algebra packages and examine the disorder-averaged expectation value of various observable properties. Sophisticated techniques exist for exploring small portions of the spectrum of large quantum systems, but as we are interested in dynamics of excited states, we require the entire spectrum, hence the method of exact diagonalization. This limits the system size we can explore because of the combinatorial growth of the Hilbert space dimension.

A first approach to this problem is to efficiently generate the Hamiltonian of the "clean" Bose-Hubbard model, referred to at the end of the tutorial by Zhang and Dong (https://arxiv.org/abs/1102.4006). The tutorial begins with generation of the Hamiltonian with respect to the position basis (I will provide a link to my implementation). With respect to the 'clean' Bose-Hubbard model, one could perform a unitary rotation on the Hamiltonian (or indeed the eigenvectors) and thus obtain the momentum eigenstates. However, matrix multiplication scales with the cube of the matrix size, which itself is combinatorially large. In the clean case, this is fine because it need only be done once. In the disordered case, one wishes to average over many realizations of the model, thus repeatedly performing an expensive coordinate transformation is undesirable.

Indeed, there may be other approaches. The method which is the most time-efficient is probably preferred, assuming that the algorithm is not too time-consuming to write. Human time is more precious than compute time! We will discuss possible approaches, or at least iron out the details of this method, before making a start.


## References
Alet & Laflorencie, [*Many-body localization: An introduction and selected topics*](https://arxiv.org/abs/1711.03145)

Abanin & Papic, [*Recent progress in many-body localization*](https://onlinelibrary.wiley.com/doi/full/10.1002/andp.201700169)

Rispoli et al, [*Quantum critical behavior at the many-body-localization transition* ](https://arxiv.org/abs/1812.06959)

Carcy et al, [*Momentum-space correlations in a Mott insulator*](https://arxiv.org/abs/1904.10995)
