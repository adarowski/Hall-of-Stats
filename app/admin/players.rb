ActiveAdmin.register Player do
  controller do
    with_role :admin
  end

  index do
    column :first_name
    column :last_name
    column :eligibility
    column :bio
    column :photo_path

    default_actions
  end

  collection_action :preview_markdown, :method => :post do
    render text: BioFormatter.new(params[:markdown])
  end

  show do
    h3 player.name
    attributes_table do
      Player.column_names.each do |name|
        if name == 'id'
          row name do
            raw(link_to player.id, player_path(player))
          end
        else
          row name
        end
      end
    end
  end

  form do |f|
    f.inputs "Attributes", id: params[:id] do
      f.input :first_name
      f.input :last_name
      f.input :position
      f.input :first_year
      f.input :last_year
      f.input :eligibility
      f.input :hof
      f.input :hos
      f.input :hall_rating

      f.input :waa0_tot
      f.input :war162_tot
      f.input :wwar
      f.input :war_pos
      f.input :war162_pos
      f.input :waa_pos
      f.input :waa_p
      f.input :war_tot
      f.input :waa_tot
      f.input :war_p
      f.input :war162_p

      f.input :peak_pct
      f.input :longevity_pct

      f.input :runs_bat
      f.input :runs_br
      f.input :runs_dp
      f.input :runs_defense
      f.input :runs_totalpos
      f.input :runs_pitch

      f.input :pa
      f.input :ip_outs


      f.input :img_url
      f.input :photo_path

      f.input :bio
    end

    f.buttons
  end
end
