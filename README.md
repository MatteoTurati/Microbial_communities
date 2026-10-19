# Stability-aware gLV identification of a synthetic microbial community

MATLAB code to reproduce the figures of the paper.

## Requirements

- MATLAB R2022b or later (tested on R2024b)
- No additional toolboxes

## Repository structure

```
├── data/                      experimental data (Excel tables)
│   ├── Tabella_S1.xlsx        single cultures
│   ├── Tabella_S2_rev.xlsx    co-cultures (S12, S13, S23)
│   ├── Tabella_S3_rev.xlsx    probiotic consortium (S123)
│   ├── Tabella_S4_rev.xlsx    core community (S4)
│   └── Tabella_S5_rev.xlsx    seven-strain community (S7)
├── fig2_fig8_stability_plane.m
├── fig3to7_dynamics_heatmap.m
├── figS_pairwise_robustness.m
├── Ode_community.m            gLV right-hand side
├── stability.m                feasibility and stability of an equilibrium
└── lognormal_noise.m          lognormal perturbation of stationary data
```

## Usage

1. Clone the repository and open MATLAB in its root folder.
2. Run the script of the figure you need:

| Script | Figures | Content |
|---|---|---|
| `fig2_fig8_stability_plane.m` | 2, 8 | Measured and lognormally perturbed co-culture ratios in the pairwise stability plane |
| `fig3to7_dynamics_heatmap.m` | 3, 4, 5, 6, 7 | Model dynamics vs data (probiotic consortium, core and seven-strain communities) and heatmap of the interaction matrix |
| `figS_pairwise_robustness.m` | S1, S2 | Robustness of pairwise stability and feasibility to changes in interaction strength and sign |

Each script runs on its own and uses the parameter values reported in the paper.

## Settings

In `fig3to7_dynamics_heatmap.m`, each section has two options at the top:

- `Community`: `"Two"` (co-cultures), `"Probiotics"` (Figures 3 and 4), `"Four"` (Figure 6), `"Seven"` (Figure 7) or `"All"`
- `Scale`: `"Log"` for a logarithmic y-axis, any other value for linear

In `fig2_fig8_stability_plane.m`, `dim` sets the number of perturbed datasets (3000 in the paper).

## Notation

Strains: 1 LP (*L. plantarum*), 2 LA (*L. acidophilus*), 3 BL (*B. animalis* subsp. *lactis*), 4 CO (*C. orbiscindens*), 5 CS (*C. symbiosum*), 6 BC (*B. cellulosilyticus*), 7 EC (*E. coli*).

gLV model: dx_i/dt = x_i (r_i + Σ_j a_ij x_j − γ_i x_i), where `A(i,j)` is the effect of strain j on strain i.

