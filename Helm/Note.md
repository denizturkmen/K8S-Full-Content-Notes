demo/ Chart.yaml          # A yaml file containing information about the Chart.
LICENSE                   # A file containing the license of the Chart (optional)
README.md                 # A readme file for usage of the Chart or other information (optional)
values.yaml               # A file where we store the variables created to directly access our Kubernetes resources.
values.schema.json        # A json schema to impose a structure on the values.yaml file (optional)
charts/                   # A directory created to use different charts within the chart or to use dependencies (optional)
crds/                     # Kubernetes Custom Resource Definitions
templates/                # The directory containing our Kubernetes resources.
templates/NOTES.txt       # Can be used to display information or usage instructions through the terminal after our Kubernetes resources are deployed (optional)
