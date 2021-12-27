ActiveAdmin.register Player do
  permit_params :eligibility, :first_name, :nickname, :hall_rating, :hof, :hos, :hom, :id,
    :last_name, :peak_pct, :position, :waa0_tot, :war162_tot, :wwar,
    :longevity_pct, :runs_bat, :runs_br, :runs_dp, :runs_defense,
    :runs_totalpos, :pa, :war_pos, :war162_pos, :waa_pos, :ip_outs, :war_p,
    :war162_p, :waa_p, :war_tot, :waa_tot, :bio, :first_year, :last_year, :runs_pitch,
    :img_url, :alt_hof, :hof_via, :hof_year, :personal_hof, :ross_hof, :dan_hof, :dalton_hof,
    :bryan_hof, :consensus, :cover_model, :compatibility_id, :franchise_rankings

  controller do
    defaults finder: :find_by_compatibility_id
  end

  index do
    column :first_name
    column :last_name
    column :eligibility
    column :bio

    actions
  end

  collection_action :preview_markdown, :method => :post do
    render text: BioFormatter.new(params[:markdown], params[:context])
  end

  show do
    h3 player.name
    attributes_table do
      Player.column_names.each do |name|
        if name == 'id'
          row name do
            raw(link_to player.id, player_path(player.id))
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
      f.input :nickname
      f.input :position
      f.input :first_year
      f.input :last_year
      f.input :eligibility
      f.input :hof
      f.input :hos
      f.input :hom
      f.input :alt_hof
      f.input :hof_via
      f.input :hof_year
      f.input :personal_hof
      f.input :ross_hof
      f.input :bryan_hof
      f.input :dan_hof
      f.input :dalton_hof
      f.input :consensus
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
      f.input :cover_model

      f.input :bio
    end

    f.actions
  end
end
