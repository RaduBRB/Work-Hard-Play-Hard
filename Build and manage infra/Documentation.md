I wanted to deepen my understanding of some Terraform concepts that always felt a bit abstract to me, especially workspaces and resource imports. I’ve seen them mentioned many times but never had a reason to actually use them in a real workflow.
This lab finally pushed me to do that. And it turned out to be much more insightful than I expected.
This is the story of what I explored, what initially didn’t make sense, and how everything eventually clicked.

🌐 1. Understanding Terraform Workspaces
The first thing I experimented with was Terraform workspaces.
At the beginning, they felt confusing. The lab expected me to create dev, qa, and prod workspaces but never explained what they really were.
I used to think workspaces were “environment containers.”
After testing them, I realised the truth:
Workspaces aren’t separate environments, they’re separate state files.
The Terraform code stays exactly the same across all workspaces.
What changes is the state, meaning Terraform can create three completely different sets of resources using the same configuration.
Once I got this, everything made sense:

Workspaces isolate state
State controls what resources Terraform thinks exist
Isolated state = isolated infrastructure

But I also saw the limitations.
Using conditionals everywhere to adapt code per‑workspace quickly becomes messy. In the real world, I’d still prefer isolated folders or even separate repos for environments. Workspaces are helpful, but not magic.

🏗️ 2. Importing Existing AWS Resources Into Terraform
Next, I tackled the part of the lab that excited me the most: importing existing resources.
Terraform is great at creating infrastructure — but managing something that already exists? That’s a different challenge.
The lab provided an existing S3 bucket in AWS. My job was to bring it under Terraform management. This is where I learned something fundamental:
Terraform cannot manage a resource unless it exists in the state file.
The import block acts as the bridge between the real-world resource and Terraform’s state.
I had to write:

The import block
The corresponding Terraform resource block

Only then could Terraform recognise the bucket as something it controls.
Another important realisation:
Importing a resource doesn’t automatically pull in its related components.
If I imported a VPC, Terraform wouldn’t magically import its subnets, route tables, gateways, NATs, or anything else.
Every single resource must be imported individually.
This is critical when dealing with existing production systems where infrastructure has been created manually or by other tools.

🧠 3. Connecting the Dots
By the time I finished the lab, a lot of previously abstract Terraform concepts started to feel concrete.
I learned:

how Terraform isolates state using workspaces
how multiple environments can be managed from the same codebase
how Terraform adopts infrastructure it didn’t originally create
how state remains the single source of truth for everything

Even though the lab didn’t explain some parts very well, working through the tasks gave me the clarity I needed.

📌 4. Final Thoughts
This lab wasn’t just about typing commands — it was about understanding how Terraform thinks.
I didn’t just create workspaces or import resources.
I learned why these things matter in real projects:

why state isolation prevents accidental cross‑environment changes
why importing resources is essential when dealing with pre-existing infrastructure
why Terraform needs explicit mapping between configuration and real resources

Most importantly, I now understand how Terraform behaves behind the scenes, and that understanding will make me much more confident when working with real-world infrastructure.