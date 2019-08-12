# Getting started

Skim the referenced in the readme. Familiarity will as the code comes together, so just try to get a sense of the langauge and the questions people ask.

The codebase this project will build will wind up somewhere between two of my other projects, which I've included in this repository. Check out my code which:
a) Generate the BH hamiltonian in the position occupation number basis. Refer to the tutorial by Zhang and Dong and try to understand what each line does.
b) Examine many-body localization on spin chains. This is very similar, structurally, to what we will implement. 

## Construction goals

The MBL transition is not a 'phase transition' in the sense that one encounters it in typical stat mech. Rather than referring to order parameters of a specific system, or class of systems averaged with respect to some ensemble of states, it refers to a change in the statistical behaviour of ensembles of realizations of systems as the noise power (or disorder strength) increases. Many-body localized systems tend to exhibit a critical disorder, above which changes in the spectral properties coincide with changes in the space- and time-correlation. Therefore, most numerical study in this field plots various quantities versus the disorder strength, averaged over many disorder realizations.

We'll look primarily at the structure of correlation functions, and attempt to calculate the MBL critical point by looking at finite-size scaling effects. Other questions may arise along the way, which we can turn to as afforded by interest and time.

### Program structure

The of the program for this investigation would look something like this:

```
## May loop the below over several system sizes/populations
fix num_bosons
fix lattice_size
## Generating the system data
for disorder_strength in disorder_strength_range:
	H, disorder_vector = generate_hamiltonian(num_bosons,lattice_size,disorder_strength)
	evals, evecs = diagonalize(H)
	save (disorder_vector,evals,evecs)
end
# The save command here is a 'checkpoint'. Modular, checkpointed code makes component testing easier and speeds up downstream development. It's good to do after critical or demanding subroutines.

## Static properties
for sample in samples
	for state in sample.eigenstates
		corr_data = compute_correlation_stats
		# This is shorthand for however-many dimensional correlations we can examine in a reasonable way

## Dynamic properties
fix init_condition # Something like a unity-filling Mott insulator or a superfluid
for sample in samples
	# NB Evaluating this line requires the eigenvectors and init_condition to be given with respect to the same basis
	init_amplitudes = dot(eigenvectors, init_condition)
	# Tiem steps usually log-distributed for efficient coverage of many time scales
	for t in time_samples 
		# Unitary evolution 
		forward_state = dot(exp(i*eigenvalues*t) , init_amplitudes)
		corr_data=compute_correlations(forward_state)
		save (forward_state,corr_data) #the nice thing about unitary evolution of pure states is we just need to save the amplitudes, not a full density matrix
		# It might be worth saving less frequently if it is possible to store all the data for a few samples in RAM before writing to disk
```

This concludes the bulk of the data generation process. From here, it's a matter of taking a ton of statistics over the thousands of 'experiments' we just ran in silico. I'll give some more details on this part later.

## Planning ahead

"Dev time is more valuable than compute time" - Chris Laumann [Probably apocryphal]
"Measure twice, cut once." - Also Chris Laumann [Definitely apocryphal]

The thrust of the above is: Premature optimization is death. Before embarking on a large computing project, it's worth the effort to determine the program architecture that minimizes *developer time* spent. In this context, we may not need to reinvent the wheel - hacking a few coordinate transformations into existing code might be faster to do, but if it blows out the compute time by a factor of ten, that might be a problem. This kind of problem can be solved in various ways: Smarter design, or bigger resources. In our case the latter means parallelizing, which may be quite effectively employed. The RSP IT department has some beefy computing clusters we could put to use. NCI is probably overkill, and an administrative pain to use. 


The key resources of concern are:
* **Memory**: The amount of RAM available is a limitation to the size of the system we can study.
* **Disk space**: This isn't likely to be a problem, but we should find an order of magnitude estimate for the 
* **Runtime**: The walltime (that is, time as measured by a clock on the wall) of a calculation can be difficult to estimate without detailed knowledge of interpreters and hardware, but the *scaling* of the cost with respect to system size can be estimated. At the end of the day, some empirical constraints are likely to be more valuable. This is especially true when writing to disk.

## Tasks

Here are some concrete tasks to work on. Some of them are interdependent, but you could easily parallelize them if you have the time.

* Get familiar with computational many-body physics by playing with the codebases I've supplied. Keep the system sizes small at first to avoid blowing out the run-time. Estimate and measure the memory, disk, and runtime scaling of these programs.
* Using what you've learened from point 1, estimate the resource requirements for the objective calculations in momentum space. Consider varying the program structure, comparing the resources and *human effort* needed for different versions.
* Build some components of the code. For example, generate some arbitrary lattice states (using the existing Bose-Hubbard code) and write code to compute correlation functions. Write the time-evolution component, including the checkpoints. Build the position-momentum coordinate transformation and/or generate the Aubry-Andre Hamiltonian directly in the momentum basis.

## Feedback

When you're working on this code, commit and push changes to a working branch on this git. I'm always available by email, and I use whatsapp with the number 0449531415 if you want to chat, or add me on facebook.